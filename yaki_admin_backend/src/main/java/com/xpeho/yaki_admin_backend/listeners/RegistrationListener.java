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
                =  "/login/registerConfirm?token=" + token;
        String message = "Please follow the link below to verify your email address." +
                " If your email address is not verified in 24 hours, your account will be deleted.";
        String subject = "Confirm your Yaki account";
        String html = registrationEmail(apiUrl, confirmationUrl);
        String customId = "Register";
        this.setSenderEmail(user.getEmail(), subject,html,customId);
    }


   private String registrationEmail(String apiUrl, String confirmationUrl) {
        String emailPart1= """
                    <div
                        style="max-width: 560px; padding: 20px; background: #ffffff; border-radius: 5px; margin: 40px auto; font-family: Open Sans,Helvetica,Arial; font-size: 15px; color: #666;">
                        <div style="color: #444444; font-weight: normal;">
                            <div style="text-align: center; font-weight: 600; font-size: 26px; padding: 10px 0; border-bottom: solid 3px #eeeeee;">YAKI</div>
                            <div style="clear: both;"> </div>
                        </div>
                        <div style="padding: 0 30px 30px 30px; border-bottom: 3px solid #eeeeee;">
                            <div style="padding: 30px 0; font-size: 24px; text-align: center; line-height: 40px;">Thank you for signing up!<span
                       style="display: block;">Please click the following link to activate your account.</span><span style="display: block;">If your
                       email address is not verified in 24 hours, your account will be deleted.</span></div>
                            <div style="padding: 10px 0 50px 0; text-align: center;"><a
                               style="background: #555555; color: #fff; padding: 12px 30px; text-decoration: none; border-radius: 3px; letter-spacing: 0.3px;"
                       href=
                """;

            String url = apiUrl + confirmationUrl;

            String emailPart2 = """
                    >Activate your Account</a></div>
                            <div style="padding: 15px; background: #eee; border-radius: 3px; text-align: center;">Need help? <a
                               style="color: #3ba1da; text-decoration: none;" href="mailto:[yaki@xpeho.fr](mailto:yaki@xpeho.fr)">contact us</a> today.</div>
                        </div>
                        <div style="color: #999; padding: 20px 30px;">
                            <div>Thank you!</div>
                            <div>The <a style="color: #3ba1da; text-decoration: none;" href="https://yaki.xpeho.fr/">YAKI</a> Team</div>
                        </div>
                    </div>
                    """;

            return emailPart1 + url + emailPart2;
    }
}
