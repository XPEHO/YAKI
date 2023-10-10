package com.xpeho.yaki_admin_backend.listeners;

import com.mailjet.client.errors.MailjetException;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.data.services.VerificationTokenServiceImpl;
import com.xpeho.yaki_admin_backend.events.OnRegistrationCompleteEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.mailjet.client.errors.MailjetSocketTimeoutException;

import java.util.UUID;

@Component
public class RegistrationListener extends EmailListener<OnRegistrationCompleteEvent> {
    @Autowired
    private VerificationTokenServiceImpl service;

    @Override
    protected void sendEmail(OnRegistrationCompleteEvent event) throws MailjetSocketTimeoutException, MailjetException {
        UserModel user = event.getUser();
        String token = UUID.randomUUID().toString();
        service.createVerificationToken(user, token);
        String confirmationUrl
                =  "/registerConfirm?token=" + token;
        String message = "Please follow the link below to verify your email address." +
                " If your email address is not verified in 24 hours, your account will be deleted.";
        String subject = "Confirm your Yaki account";
        String html = "<html><body>" + message + "<br><a href=" + uiUrl + confirmationUrl + ">Confirm Registration</a></body></html>";
        String customId = "Register";
        this.setSenderEmail(user.getEmail(), subject,html,customId);
    }
}
