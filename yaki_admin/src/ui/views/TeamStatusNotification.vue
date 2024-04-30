<script setup lang="ts">
import avatar from "@/assets/images/avatarLetters.png";

import DeletedTeamTutoriel from "@/ui/components/tutoriels/DeletedTeamTutoriel.vue";
import NoTeamTutoriel from "@/ui/components/tutoriels/NoTeamTutoriel.vue";
import { useTeamStore } from "@/stores/teamStore";
import { useRoute } from "vue-router";

const teamStore = useTeamStore();

const route = useRoute();
const teamParamState = route.params.state;
</script>

<template>
  <section class="no-team__container">
    <deleted-team-tutoriel
      v-if="teamParamState === 'deleted'"
      :teamName="teamStore.getTeamDeleted.teamName"
      :teamLogo="avatar"
      :captainTeamListLenght="teamStore.getTeamListByCaptain.length"
    />
    <no-team-tutoriel
      v-else
      :teamLogo="avatar"
    />
  </section>
</template>

<style lang="scss">
.no-team__container {
  background-color: #ecf0f5;

  padding-block-start: 10rem;

  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.tutoriel-deleted-team__container {
  max-width: 35rem;

  display: flex;
  flex-direction: column;
  align-items: center;
}

.deleted-team__figure {
  padding-block-start: 1rem;
  max-width: 10rem;

  img {
    width: 100%;
    object-fit: cover;
  }
}
</style>
