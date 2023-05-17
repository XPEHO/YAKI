<script setup lang="ts">
import { onBeforeMount, onMounted, onUpdated, reactive, ref } from 'vue';
import TeamListElement from '@/features/captain/components/TeamListElement.vue';
import SideBarElement from '@/shared/components/SideBarElement.vue';
import isTeamSelected from '../services/isActiveTeam';
import vector from '@/assets/Vector.png';

const teams = reactive({
  list: ['Team 1', 'Team 2', 'Team 3', 'Team 4', 'Team 5'],
});

const selectedTeam = (teamName: string) => {
  isTeamSelected.setTeam(teamName);
};
</script>

<template>
  <side-bar-element
    v-bind:innerText="'My teams'"
    v-bind:iconPath="vector"
    v-bind:isSelected="true"
  />

  <section class="team-list">
    <team-list-element
      v-for="(team, index) in teams.list"
      :key="index"
      @click="() => selectedTeam(team)"
      v-bind:teamName="team"
    />
  </section>
</template>

<style lang="scss">
.team-list {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}
</style>
