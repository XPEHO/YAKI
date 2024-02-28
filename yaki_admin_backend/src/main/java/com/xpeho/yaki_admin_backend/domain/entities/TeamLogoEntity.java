package com.xpeho.yaki_admin_backend.domain.entities;

import java.util.Arrays;
import java.util.Objects;

public record TeamLogoEntity(int teamId, byte[] teamLogoBlob) {

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TeamLogoEntity that = (TeamLogoEntity) o;
        return teamId == that.teamId &&
                Arrays.equals(teamLogoBlob, that.teamLogoBlob);
    }

    @Override
    public int hashCode() {
        int result = Objects.hash(teamId);
        result = 31 * result + Arrays.hashCode(teamLogoBlob);
        return result;
    }

    @Override
    public String toString() {
        return "TeamLogoEntity{" +
                "teamId=" + teamId +
                ", teamLogoBlob=" + Arrays.toString(teamLogoBlob) +
                '}';
    }
}
