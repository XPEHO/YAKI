package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.PrimaryKeyJoinColumn;
import jakarta.persistence.Table;
import org.springframework.data.annotation.Id;
@Table(name = "captain")
@Entity
@PrimaryKeyJoinColumn(name = "captain_user_id")
public class CaptainModel extends UserModel{
    @Id
    @Column(name = "captain_id")

    int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public CaptainModel(int id) {
        this.id = id;
    }
    public CaptainModel() {
    }
}
