package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

import java.util.ArrayList;
import java.util.List;


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
    @JoinTable(name = "customer_rights", joinColumns = @JoinColumn(name = "customer_rights_customer_id"), inverseJoinColumns = @JoinColumn(name = "customer_rights_user_id"))
    private List<UserModel> users = new ArrayList<>();

    @Column(name = "customer_location_id")
    private int locationId;

    public CustomerModel() {

    }

    public CustomerModel(int id, OwnerModel owner, String name, int ownerId, List<UserModel> users, int locationId) {
        this.id = id;
        this.owner = owner;
        this.name = name;
        this.ownerId = ownerId;
        this.users = users;
        this.locationId = locationId;
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

    public void setName(String name) {
        this.name = name;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public int getLocationId() {
        return this.locationId;
    }

    public void setLocationId(int locationId) {
        this.locationId = locationId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public OwnerModel getOwner() {
        return owner;
    }

    public void setOwner(OwnerModel owner) {
        this.owner = owner;
    }

    public List<UserModel> getUsers() {
        return users;
    }

    public void setUsers(List<UserModel> users) {
        this.users = users;
    }
}
