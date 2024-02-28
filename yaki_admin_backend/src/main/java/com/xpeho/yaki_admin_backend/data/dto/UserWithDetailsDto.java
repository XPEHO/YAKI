package com.xpeho.yaki_admin_backend.data.dto;

import java.util.Arrays;
import java.util.Objects;

public record UserWithDetailsDto(
        Integer id,
        Integer captainId,
        String lastName,
        String firstName,
        String email,
        String avatarReference,
        byte[] avatarBlob) {

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        UserWithDetailsDto that = (UserWithDetailsDto) o;
        return Objects.equals(id, that.id) &&
                Objects.equals(captainId, that.captainId) &&
                Objects.equals(lastName, that.lastName) &&
                Objects.equals(firstName, that.firstName) &&
                Objects.equals(email, that.email) &&
                Objects.equals(avatarReference, that.avatarReference) &&
                Arrays.equals(avatarBlob, that.avatarBlob);
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(id, captainId, lastName, firstName, email, avatarReference);
        result = 31 * result + Arrays.hashCode(avatarBlob);
        return result;
    }

    @Override
    public String toString() {
        return "UserWithDetailsDto{" +
                "id=" + id +
                ", captainId=" + captainId +
                ", lastName='" + lastName + '\'' +
                ", firstName='" + firstName + '\'' +
                ", email='" + email + '\'' +
                ", avatarReference='" + avatarReference + '\'' +
                ", avatarBlob=" + Arrays.toString(avatarBlob) +
                '}';
    }
}
