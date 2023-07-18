package com.xpeho.yaki_admin_backend.listeners;

import com.mailjet.client.errors.MailjetException;
import com.mailjet.client.resource.Email;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.services.VerificationTokenServiceImpl;
import com.xpeho.yaki_admin_backend.domain.services.VerificationTokenService;
import com.xpeho.yaki_admin_backend.events.OnRegistrationCompleteEvent;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationListener;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Component;
import com.mailjet.client.MailjetRequest;
import com.mailjet.client.errors.MailjetSocketTimeoutException;
import com.mailjet.client.MailjetClient;
import com.mailjet.client.MailjetRequest;
import com.mailjet.client.MailjetResponse;
import com.mailjet.client.ClientOptions;
import com.mailjet.client.resource.Emailv31;

import java.util.UUID;

@Component
public class RegistrationListener implements ApplicationListener<OnRegistrationCompleteEvent> {
    @Autowired
    private VerificationTokenServiceImpl service;
    @Value("${MAILJET_API_KEY:key}")
    String apiKey;
    @Value("${MAILJET_SECRET_KEY:secret}")
    String secretKey;
    //only for testing purposes, we need to give the email of the person
    @Value("${MAILJET_SENDER_EMAIL:mail}")
    String senderEmail;
    @Value("${ADMIN_API_URL:url}")
    String apiUrl;

    @Override
    public void onApplicationEvent(OnRegistrationCompleteEvent event) {
        try {
            this.confirmRegistration(event);
        } catch (MailjetSocketTimeoutException e) {
            throw new RuntimeException(e);
        } catch (MailjetException e) {
            throw new RuntimeException(e);
        }
    }

    private void confirmRegistration(OnRegistrationCompleteEvent event) throws MailjetSocketTimeoutException, MailjetException {
        //need to add check if the email exist or not and check if the response is 200
        //test that the email is not alredy used
        //maybe clean all of that because the request is huge
        UserModel user = event.getUser();
        String token = UUID.randomUUID().toString();
        service.createVerificationToken(user, token);
        String confirmationUrl
                =  "/login/registerConfirm?token=" + token;
        String message = "Please follow the lonk below to verify your email address. If your email address is not verified in 24 hours, your account will be deleted.";
        MailjetClient client = new MailjetClient(apiKey,secretKey,new ClientOptions("v3.1"));
        // Create a Mailjet Request with the Emailv31 resource
        MailjetRequest request = new MailjetRequest(Emailv31.resource)
                .property(Emailv31.MESSAGES, new JSONArray()
                        .put(new JSONObject()
                                .put(Emailv31.Message.FROM, new JSONObject()
                                        .put("Email", senderEmail)
                                        .put("Name", "Do not reply"))
                                .put(Emailv31.Message.TO, new JSONArray()
                                        .put(new JSONObject()
                                                .put("Email", user.getEmail())
                                                .put("Name", "Do not reply")))
                                .put(Emailv31.Message.SUBJECT, "Confirm your Yaki account")
                                .put(Emailv31.Message.TEXTPART, "Yaki")
                                .put(Emailv31.Message.HTMLPART, "<html><body>" + message + "<br><a href=" + apiUrl + confirmationUrl + ">Confirm Registration</a></body></html>")
                                .put(Emailv31.Message.CUSTOMID, "AppGettingStartedTest")));
        MailjetResponse response = client.post(request);

    }
}
