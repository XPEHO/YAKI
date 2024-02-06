package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

@Table(name = "\"avatar\"", schema = "public")
@Entity
public class AvatarModel {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "avatar_seq")
    @SequenceGenerator(name = "avatar_seq", sequenceName = "avatar_id_seq", allocationSize = 1)
    @Column(name = "avatar_id")
    private Integer avatarId;

    @Column(name = "avatar_reference")
    private String avatarReference;

    @Column(name = "avatar_blob")
    private byte[] avatarBlob;

    @Column(name = "avatar_is_validated")
    private Boolean avatarIsValidated;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "avatar_user_id", nullable = false)
    private UserModel user;


    public AvatarModel() {
}

public AvatarModel(String avatarReference, byte[] avatarBlob, Boolean avatarIsValidated, UserModel user) {
    this.avatarReference = avatarReference;
    this.avatarBlob = avatarBlob;
    this.avatarIsValidated = avatarIsValidated;
    this.user = user;
}

    public UserModel getUser() {
        return this.user;
    }

    public void setUser(UserModel user) {
        this.user = user;
    }

    public Integer getAvatarId() {
        return this.avatarId;
    }

    public void setAvatarId(Integer avatarId) {
        this.avatarId = avatarId;
    }

    public String getAvatarReference() {
        return this.avatarReference;
    }

    public void setAvatarReference(String avatarReference) {
        this.avatarReference = avatarReference;
    }

    public byte[] getAvatarBlob() {
        return this.avatarBlob;
    }

    public void setAvatarBlob(byte[] avatarBlob) {
        this.avatarBlob = avatarBlob;
    }

    public Boolean getAvatarIsValidated() {
        return this.avatarIsValidated;
    }

    public void setAvatarIsValidated(Boolean avatarIsValidated) {
        this.avatarIsValidated = avatarIsValidated;
    }
}
