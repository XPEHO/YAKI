package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name = "customer", schema = "public")
public class CustomerModel {


    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "customer_id")
    private int id;
    @ManyToOne()
    @JoinColumn(name = "customer_owner_id", insertable = false, updatable = false)
    private OwnerModel owner;
    @Column(name = "customer_name")
    private String name;
    @Column(name = "customer_owner_id")
    private int ownerId;

    @OneToMany
    @Column(name = "customer_user_id")
    private List<UserModel> user;



    /*@OneToOne
    @JoinColumn(name = "customer_location_id")
    private LocationModel location;*/


    public CustomerModel(String customer_name, int ownerId) {
        this.user = new ArrayList<>();
        this.ownerId = ownerId;
        this.name = customer_name;
    }

    public void addUsers(List<UserModel> users) {
        this.user.addAll(users);
    }

    public String getName() {
        return name;
    }

    public int getOwnerId() {
        return ownerId;
    }
}
