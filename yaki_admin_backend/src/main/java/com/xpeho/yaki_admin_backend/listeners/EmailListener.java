package com.xpeho.yaki_admin_backend.listeners;

import com.mailjet.client.ClientOptions;
import com.mailjet.client.MailjetClient;
import com.mailjet.client.MailjetRequest;
import com.mailjet.client.MailjetResponse;
import com.mailjet.client.errors.MailjetException;
import com.mailjet.client.errors.MailjetSocketTimeoutException;
import com.mailjet.client.resource.Emailv31;
import com.xpeho.yaki_admin_backend.data.services.VerificationTokenServiceImpl;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationEvent;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

@Component
public abstract class EmailListener<E extends ApplicationEvent> implements ApplicationListener<E> {
    @Autowired
    private VerificationTokenServiceImpl service;
    @Value("${MAILJET_API_KEY:key}")
    String apiKey;
    @Value("${MAILJET_SECRET_KEY:secret}")
    String secretKey;
    //only for testing purposes, we need to give the email of the person
    @Value("${MAILJET_SENDER_EMAIL:mail}")
    String senderEmail;
    @Value("${ADMIN_UI_URL:url}")
    String uiUrl;
    protected MailjetRequest request;
    @Override
    public void onApplicationEvent(E event) {
        try {
            this.sendEmail(event);
        } catch (MailjetSocketTimeoutException e) {
            throw new RuntimeException(e);
        } catch (MailjetException e) {
            throw new RuntimeException(e);
        }
    }
    protected abstract void sendEmail(E event) throws MailjetSocketTimeoutException, MailjetException;
    protected void setSenderEmail(String toEmail, String subject, String text, String customerId) throws MailjetSocketTimeoutException, MailjetException{
        request = new MailjetRequest(Emailv31.resource)
                .property(Emailv31.MESSAGES, new JSONArray()
                        .put(new JSONObject()
                                .put(Emailv31.Message.FROM, new JSONObject()
                                        .put("Email", senderEmail)
                                        .put("Name", "Do not reply"))
                                .put(Emailv31.Message.TO, new JSONArray()
                                        .put(new JSONObject()
                                                .put("Email", toEmail)
                                                .put("Name", "Do not reply")))
                                .put(Emailv31.Message.SUBJECT, subject)
                                .put(Emailv31.Message.TEXTPART, "Yaki")
                                .put(Emailv31.Message.HTMLPART, text)
                                .put(Emailv31.Message.CUSTOMID, customerId)));
        MailjetClient client = new MailjetClient(apiKey,secretKey,new ClientOptions("v3.1"));
        if(!apiKey.equals("key") ) {
            MailjetResponse response = client.post(request);
        }

    }
}
