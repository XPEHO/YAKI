<script setup lang="ts">
import TeamInfoCard from "@/ui/components/TeamInfoCard.vue";
import { TeamType } from "@/models/team.type";
import { PropType } from "vue";

defineProps({
  teamList: {
    type: Object as PropType<TeamType[]>,
    required: true,
  },
});
</script>

<template>
  <section class="user-list__container">
    <section class="user-list__in-team-container">
      <team-info-card
        v-for="team in teamList"
        :team="team"
        :key="team.id"
      />
    </section>
  </section>
</template>

<style scoped lang="scss">
$border-radius: 24px;
.user-list__container {
  padding-block-end: 10rem;

  > p:nth-of-type(1) {
    padding-block-end: 32px;
  }

  > p:nth-of-type(2) {
    padding-block-end: 16px;
  }

  .user-list__in-team-container {
    border-radius: $border-radius;
    article:nth-of-type(1) {
      border-top-left-radius: $border-radius;
      border-top-right-radius: $border-radius;
    }

    article:last-of-type {
      border-bottom-left-radius: $border-radius;
      border-bottom-right-radius: $border-radius;
    }
  }
}
</style>
