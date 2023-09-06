package com.xpeho.yaki_admin_backend.events;

import com.xpeho.yaki_admin_backend.data.models.UserModel;
import org.springframework.context.ApplicationEvent;

public class OnResetPasswordCompletEvent extends ApplicationEvent {
    private UserModel user;
    private String password;
    private final String appUrl = "";

    public String getAppUrl() {
        return appUrl;
    }

    public OnResetPasswordCompletEvent(
            UserModel user, String password) {
        super(user);
        this.user = user;
        this.password = password;
    }

    public UserModel getUser() {
        return user;
    }

    public void setUser(UserModel user) {
        this.user = user;
    }

    public String getPassword() {
        return password;
    }

}
