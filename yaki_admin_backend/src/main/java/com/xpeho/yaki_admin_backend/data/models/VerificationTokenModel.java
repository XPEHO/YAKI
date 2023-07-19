package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

import java.security.Timestamp;
import java.util.Calendar;
import java.util.Date;

@Entity
@Table(name = "verification_token", schema = "public")
public class VerificationTokenModel {
    private static final int EXPIRATION = 60 * 24;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "verification_token_seq")
    @SequenceGenerator(name = "verification_token_seq", sequenceName = "verification_token_id_seq", allocationSize = 1)
    @Column(name = "verification_token_id")
    private Long id;

    @Column(name = "token")
    private String token;

    @OneToOne(targetEntity = UserModel.class, fetch = FetchType.EAGER)
    @JoinColumn(nullable = false, name = "verification_token_user_id")
    private UserModel user;

    @Column(name = "expiration_date")
    private Date expiryDate;
//is it working properly ? test with 1 minute
    private Date calculateExpiryDate(int expiryTimeInMinutes) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date(System.currentTimeMillis()));
        cal.add(Calendar.MINUTE, expiryTimeInMinutes);
        return new Date(cal.getTime().getTime());
    }

    public VerificationTokenModel() {
    }

    public VerificationTokenModel(String token, UserModel user) {
        this.token = token;
        this.user = user;
        this.expiryDate = calculateExpiryDate(EXPIRATION);
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public UserModel getUser() {
        return user;
    }

    public void setUser(UserModel user) {
        this.user = user;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }
}
