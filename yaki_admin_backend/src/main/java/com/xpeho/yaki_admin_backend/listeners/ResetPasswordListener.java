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
        String divStyle = "<div style=\"font-size:16px\">";
        String htmlDivPassword = """
        <div style=\"background:#faf9fa;border:1px solid #dad8de;text-align:center;
        margin:0.5rem 0;font-size:24px;line-height:1.5;
        width : min(90%,20rem);\">""";
        String endDiv = "</div>";
        String message = divStyle.concat("Your password has been reset. Your new temporary password is: ")
                .concat(endDiv)
                .concat(htmlDivPassword)
                .concat(password)
                .concat(endDiv)
                .concat(divStyle)
                .concat("Please change your password after logging in.")
                .concat(endDiv);
        String subject = "Your Yaki password has been reset";
        String html = "<html><body>" + message + "</body></html>";
        String customId = "Reset your password";
        this.setSenderEmail(user.getEmail(), subject,html,customId);
    }
}
