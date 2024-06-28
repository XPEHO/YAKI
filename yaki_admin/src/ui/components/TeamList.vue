<script setup lang="ts">
import TeamInfoCard from "@/ui/components/TeamInfoCard.vue";
import { TeamType } from "@/models/team.type";
import { onBeforeMount, PropType, ref } from "vue";
import { useStatisticsStore } from "@/stores/statisticsStore";

const statisticsStore = useStatisticsStore();

const props = defineProps({
  teamList: {
    type: Object as PropType<TeamType[]>,
    required: true,
  },
});

const teamListValue: TeamType[] = [...props.teamList];
let teamWithLatestActivity = ref<TeamType[]>([]);

onBeforeMount(async () => {
  await statisticsStore.setTeamsLatestActivityByCustomerId(teamListValue[0].customerId);
  const teamLatestActivities = [...statisticsStore.getTeamsLatestActivity];

  for (let team of teamListValue) {
    for (let latestActivity of teamLatestActivities) {
      if (team.id.toString() === latestActivity.teamId) {
        const teamWithDetails: TeamType = {
          ...team,
          lastActivity: latestActivity.lastActivityDate,
        };
        teamWithLatestActivity.value = [...teamWithLatestActivity.value, teamWithDetails];
      }
    }
  }
});
</script>

<template>
  <section class="user-list__container">
    <section class="user-list__in-team-container">
      <team-info-card
        v-for="team in teamWithLatestActivity"
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
