package com.xpeho.yaki_admin_backend.data.models;

import jakarta.persistence.*;

import java.util.Date;

@Entity
@Table(name = "entity_log", schema = "public")
public class EntityLogModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "entity_log_seq")
    @SequenceGenerator(name = "entity_log_seq", sequenceName = "entity_log_id_seq", allocationSize = 1)
    @Column(name = "entity_log_id")
    int id;
    @Column(name = "entity_log_creation_date")
    Date creationDate;

    @Column(name = "entity_log_inactivation_date")
    Date inactivationDate;

    public EntityLogModel(Date creationDate) {
        this.creationDate = creationDate;
    }

    public EntityLogModel() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getInactivationDate() {
        return inactivationDate;
    }

    public void setInactivationDate(Date inactivationDate) {
        this.inactivationDate = inactivationDate;
    }
}
