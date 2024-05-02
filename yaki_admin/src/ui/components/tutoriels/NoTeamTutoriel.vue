<script setup lang="ts">
import tutorial from "@/assets/images/tuto_team_creation.png";
</script>

<template>
  <div class="tutoriel-deleted-team__container">
    <p class="p-tutoriel-main p-tutoriel-common">{{ $t("teamStatus.noTeam") }}</p>
    <p class="p-tutoriel-secondary p-tutoriel-common margin-top-3">
      {{ $t("teamStatus.howToCreateATeam2") }} <span>{{ $t("teamStatus.createTeam") }}</span>
    </p>
    <figure class="tutorial_size">
      <img
        :src="tutorial"
        alt=""
      />
    </figure>
  </div>
</template>

<style lang="scss">
.tutorial_size {
  padding-block-start: 1rem;
  max-width: 20rem;
  border-radius: 16px;

  img {
    width: 100%;
    object-fit: cover;
    border-radius: 16px;
  }
}
</style>
