package com.xpeho.yaki_admin_backend.domain.entities.statistics;

import org.springframework.cglib.core.Local;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;

public class DeclarationsListEntity extends StatisticsEntity{
    String teamName;
    String firstName;
    String lastName;
    String declarationStatus;
    LocalDateTime declarationDate;
    LocalDateTime declarationDateStart;
    LocalDateTime declarationDateEnd;

    public DeclarationsListEntity() {
    }

    public DeclarationsListEntity(String teamName, String firstName, String lastName, String declarationStatus, LocalDateTime declarationDate, LocalDateTime declarationDateStart, LocalDateTime declarationDateEnd) {
        this.teamName = teamName;
        this.firstName = firstName;
        this.lastName = lastName;
        this.declarationStatus = declarationStatus;
        this.declarationDate = declarationDate;
        this.declarationDateStart = declarationDateStart;
        this.declarationDateEnd = declarationDateEnd;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getDeclarationStatus() {
        return declarationStatus;
    }

    public void setDeclarationStatus(String declarationStatus) {
        this.declarationStatus = declarationStatus;
    }

    public LocalDateTime getDeclarationDate() {
        return declarationDate;
    }

    public void setDeclarationDate(LocalDateTime declarationDate) {
        this.declarationDate = declarationDate;
    }

    public LocalDateTime getDeclarationDateStart() {
        return declarationDateStart;
    }

    public void setDeclarationDateStart(LocalDateTime declarationDateStart) {
        this.declarationDateStart = declarationDateStart;
    }

    public LocalDateTime getDeclarationDateEnd() {
        return declarationDateEnd;
    }

    public void setDeclarationDateEnd(LocalDateTime declarationDateEnd) {
        this.declarationDateEnd = declarationDateEnd;
    }
}
