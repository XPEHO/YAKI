package com.xpeho.yaki_admin_backend.listeners;

import com.mailjet.client.errors.MailjetException;
import com.mailjet.client.errors.MailjetSocketTimeoutException;
import com.xpeho.yaki_admin_backend.data.models.UserModel;
import com.xpeho.yaki_admin_backend.events.OnResetPasswordCompletEvent;
import org.springframework.stereotype.Component;



@Component
public class ResetPasswordListener extends EmailListener<OnResetPasswordCompletEvent>{
    @Override
    protected void sendEmail(OnResetPasswordCompletEvent event) throws MailjetSocketTimeoutException, MailjetException {
        System.out.println("Sending email 2");
        UserModel user = event.getUser();
        String password = event.getPassword();
        String message = "Your password has been reset. Your new temporary password is: " + password + ". Please change your password after logging in.";
        String subject = "Your Yaki password has been reset";
        String html = "<html><body>" + message + "</body></html>";
        String customId = "Reset your password";
        this.setSenderEmail(user.getEmail(), subject,html,customId);
    }
}
