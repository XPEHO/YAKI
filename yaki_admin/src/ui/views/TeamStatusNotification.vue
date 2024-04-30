<script setup lang="ts">
import Tutorial from "@/assets/images/tuto_team_creation.png";
import avatar from "@/assets/images/avatarLetters.png";
import { useTeamStore } from "@/stores/teamStore";
import { useRoute } from "vue-router";

const teamStore = useTeamStore();

const route = useRoute();
const teamParamState = route.params.state;

import { useI18n } from "vue-i18n";

const { locale } = useI18n();
</script>

<template>
  <section class="no-team__container">
    <div
      v-if="teamParamState === 'deleted'"
      class="no-team-in-list"
    >
      <p class="p_main p_common">
        {{ $t("teamStatus.deletedTeamName") }}{{ teamStore.getTeamDeleted.teamName }}
      </p>
      <figure class="deleted_team__figure">
        <img
          :src="avatar"
          alt=""
        />
      </figure>
      <p class="p_secondary p_common margin-top-2">
        {{ $t("teamStatus.deletedTeamConfirmation") }}
      </p>

      <div
        v-if="teamStore.getTeamListByCaptain.length === 0"
        class="margin-top-3"
      >
        <p class="p_secondary p_common">{{ $t("teamStatus.noTeamLeft") }}</p>
        <p
          v-if="locale == 'en'"
          class="p_secondary p_common margin-top-1"
        >
          {{ $t("teamStatus.howToCreateATeam1") }}
          <span>{{ $t("teamStatus.createTeam") }}</span>
          {{ $t("teamStatus.option") }}
        </p>
        <p
          v-else
          class="p_secondary p_common margin-top-1"
        >
          {{ $t("teamStatus.howToCreateATeam1") }}
          <span>{{ $t("teamStatus.createTeam") }}</span>
        </p>
      </div>
    </div>

    <div
      v-else
      class="no-team-in-list"
    >
      <p class="p_main p_common">{{ $t("teamStatus.noTeam") }}</p>
      <p class="p_secondary p_common margin-top-3">
        {{ $t("teamStatus.howToCreateATeam2") }} <span>{{ $t("teamStatus.createTeam") }}</span>
      </p>
      <figure class="no_team__figure">
        <img
          :src="Tutorial"
          alt=""
        />
      </figure>
    </div>
  </section>
</template>

<style scoped lang="scss">
.margin-top-3 {
  margin-top: 3rem;
}

.margin-top-2 {
  margin-top: 2rem;
}

.margin-top-1 {
  margin-top: 1rem;
}
.no-team__container {
  background-color: #ecf0f5;

  padding-block-start: 10rem;

  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.no-team-in-list {
  max-width: 35rem;

  display: flex;
  flex-direction: column;
  align-items: center;
}
.p_common {
  color: #7d818c;
  text-align: center;
}
.p_main {
  font-family: $font-sf-compact;
  font-size: 1.4rem;
  font-weight: 800;
  line-height: 120%;
}

.p_secondary {
  font-family: $font-sf-compact;
  font-size: 1.2rem;
  font-weight: 500;

  span {
    font-weight: 700;
  }
}

.deleted_team__figure {
  padding-block-start: 1rem;
  max-width: 10rem;

  img {
    width: 100%;
    object-fit: cover;
  }
}

.no_team__figure {
  padding-block-start: 2rem;
  max-width: 20rem;
  border-radius: 16px;

  img {
    width: 100%;
    object-fit: cover;
    filter: grayscale(20%);
    border-radius: 16px;
  }
}
</style>
