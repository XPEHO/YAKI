package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "owner", schema = "public")
public class OwnerModel {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO, generator = "owner_seq")
    @SequenceGenerator(name = "owner_seq", sequenceName = "owner_id_seq", allocationSize = 1)
    @Column(name = "owner_id")
    int id;

    @Column(name = "owner_user_id")
    int userId;

    public OwnerModel(int userId) {
        this.userId = userId;
    }

    public OwnerModel() {
    }

    public int getId() {
        return id;
    }

    public int getUserId() {
        return userId;
    }
}
