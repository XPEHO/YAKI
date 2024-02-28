package com.xpeho.yaki_admin_backend.domain.entities;

import java.util.Arrays;
import java.util.Objects;

public record UserEntityWithID(
        Integer id,
        Integer captainId,
        Integer teammateId,
        String lastname,
        String firstname,
        String email,
        String avatarReference,
        byte[] avatarBlob) {
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserEntityWithID that = (UserEntityWithID) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(captainId, that.captainId) &&
                Objects.equals(teammateId, that.teammateId) &&
                Objects.equals(lastname, that.lastname) &&
                Objects.equals(firstname, that.firstname) &&
                Objects.equals(email, that.email) &&
                Objects.equals(avatarReference, that.avatarReference) &&
                Arrays.equals(avatarBlob, that.avatarBlob);
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(id, captainId, teammateId, lastname, firstname, email, avatarReference);
        result = 31 * result + Arrays.hashCode(avatarBlob);
        return result;
    }

    @Override
    public String toString() {
        return "UserEntityWithID{" +
                "id=" + id +
                ", captainId=" + captainId +
                ", teammateId=" + teammateId +
                ", lastname='" + lastname + '\'' +
                ", firstname='" + firstname + '\'' +
                ", email='" + email + '\'' +
                ", avatarReference='" + avatarReference + '\'' +
                ", avatarBlob=" + Arrays.toString(avatarBlob) +
                '}';
    }
}
