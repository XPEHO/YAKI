package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;


@AllArgsConstructor
@Data
@Entity
@Table(name = "customer", schema = "public")
public class CustomerModel {


    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "customer_seq")
    @SequenceGenerator(name = "customer_seq", sequenceName = "customer_id_seq", allocationSize = 1)
    @Column(name = "customer_id")
    private int id;
    @ManyToOne()
    @JoinColumn(name = "customer_owner_id", insertable = false, updatable = false)
    private OwnerModel owner;
    @Column(name = "customer_name")
    private String name;
    @Column(name = "customer_owner_id")
    private int ownerId;

    @ManyToMany
    @JoinTable(name = "customer_rights",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "customer_id"))
    private List<UserModel> users = new ArrayList<>();

    @Column(name = "customer_location_id")
    private int locationId;

    public CustomerModel() {

    }

    public CustomerModel(String customerName, int ownerId, int locationId) {
        this.ownerId = ownerId;
        this.name = customerName;
        this.locationId = locationId;
    }

    public void addUsers(List<UserModel> users) {
        this.users.addAll(users);
    }

    public String getName() {
        return name;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public int getLocationId() {
        return this.locationId;
    }
}
