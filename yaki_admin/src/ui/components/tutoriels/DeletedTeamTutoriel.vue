<script setup lang="ts">
import { useI18n } from "vue-i18n";
const { locale } = useI18n();

defineProps({
  teamName: {
    type: String,
    required: true,
  },
  teamLogo: {
    type: String,
    required: true,
  },
  captainTeamListLenght: {
    type: Number,
    required: true,
  },
});
</script>

<template>
  <div class="tutoriel-deleted-team__container">
    <p class="p-tutoriel-main p-tutoriel-common">
      {{ $t("teamStatus.deletedTeamName") }}{{ teamName }}
    </p>
    <figure class="deleted-team__figure">
      <img
        :src="teamLogo"
        alt=""
      />
    </figure>
    <p class="p-tutoriel-secondary p-tutoriel-common margin-top-2">
      {{ $t("teamStatus.deletedTeamConfirmation") }}
    </p>

    <div
      v-if="captainTeamListLenght === 0"
      class="margin-top-3"
    >
      <p class="p-tutoriel-secondary p-tutoriel-common">{{ $t("teamStatus.noTeamLeft") }}</p>
      <p
        v-if="locale == 'en'"
        class="p-tutoriel-secondary p-tutoriel-common margin-top-1"
      >
        {{ $t("teamStatus.howToCreateATeam1") }}
        <span>{{ $t("teamStatus.createTeam") }}</span>
        {{ $t("teamStatus.option") }}
      </p>
      <p
        v-else
        class="p-tutoriel-secondary p-tutoriel-common margin-top-1"
      >
        {{ $t("teamStatus.howToCreateATeam1") }}
        <span>{{ $t("teamStatus.createTeam") }}</span>
      </p>
    </div>
  </div>
</template>
