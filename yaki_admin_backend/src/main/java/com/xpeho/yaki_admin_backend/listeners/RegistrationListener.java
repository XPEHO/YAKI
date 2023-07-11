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

    @Autowired
    private MessageSource messages;
    @Value("${MAILJET_API_KEY}")
    String apiKey;
    @Value("${MAILJET_SECRET_KEY}")
    String secretKey;
    //only for testing purposes, we need to give the email of the person
    @Value("${MAILJET_TEST_EMAIL}")
    String testEmail;

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
        //maybe clean all of that because the request is huge
        UserModel user = event.getUser();
        String token = UUID.randomUUID().toString();
        service.createVerificationToken(user, token);

        //String recipientAddress = user.getEmail();
        String confirmationUrl
                =  "/login/registerConfirm?token=" + token;
        String message = "Registration successful!";
        MailjetClient client = new MailjetClient(apiKey,secretKey,new ClientOptions("v3.1"));
        // Create a Mailjet Request with the Emailv31 resource
        MailjetRequest request = new MailjetRequest(Emailv31.resource)
                .property(Emailv31.MESSAGES, new JSONArray()
                        .put(new JSONObject()
                                .put(Emailv31.Message.FROM, new JSONObject()
                                        .put("Email", testEmail)
                                        .put("Name", "Profotoce"))
                                .put(Emailv31.Message.TO, new JSONArray()
                                        .put(new JSONObject()
                                                .put("Email", testEmail)
                                                .put("Name", "Profotoce")))
                                .put(Emailv31.Message.SUBJECT, "Greetings from Mailjet.")
                                .put(Emailv31.Message.TEXTPART, "My first Mailjet email")
                                .put(Emailv31.Message.HTMLPART, "<html><body>" + message + "<br><a href=\"http://localhost:8080" + confirmationUrl + "\">Confirm Registration</a></body></html>")
                                .put(Emailv31.Message.CUSTOMID, "AppGettingStartedTest")));
        MailjetResponse response = client.post(request);

    }
}
