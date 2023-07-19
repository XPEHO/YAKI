package com.xpeho.yaki_admin_backend.events;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import org.springframework.context.ApplicationEvent;

import java.util.Locale;

public class OnRegistrationCompleteEvent extends ApplicationEvent {
    private UserModel user;
    private final String appUrl = "";

    public String getAppUrl() {
        return appUrl;
    }

    public OnRegistrationCompleteEvent(
            UserModel user) {
        super(user);
        this.user = user;
    }

    public UserModel getUser() {
        return user;
    }

    public void setUser(UserModel user) {
        this.user = user;
    }
}
