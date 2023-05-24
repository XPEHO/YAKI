<script setup lang="ts">
import { onBeforeMount, onMounted, onUpdated, reactive, ref } from 'vue';
import TeamListElement from '@/features/captain/components/TeamListElement.vue';
import SideBarElement from '@/shared/components/SideBarElement.vue';
import isTeamSelected from '../services/isActiveTeam';
import vector from '@/assets/Vector.png';
import type { TeamType } from '@/services/team.type';
import { teamService } from '@/services/team.service';
import {useTeamStore} from '@/stores/teamStore';
const store = useTeamStore();
const teams = reactive({
  list: [] as TeamType[],
});
onBeforeMount(async () => {
  teams.list = await teamService.getAllTeamsWithinCaptain(2);
  
});
const selectedTeam = (id: number) => {
  isTeamSelected.setTeam(id);
  store.setTeam(id)
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
      @click="() => selectedTeam(team.id)"
      v-bind:id="team.id"
      v-bind:teamName="team.teamName"
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
