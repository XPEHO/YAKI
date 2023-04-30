<template>
   <div>
    <h1 class="title">Team Members</h1>
    <p class="text">Manage your team members here</p>
    <ul>
      <li v-for="teamMate in teamMates" :key="teamMate.id">
        <TeamMate :team-mate="teamMate" />
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { teamMateService } from '../../../services/teamMate.service'
import type { TeamMateType } from '../../../services/teamMate.type';
import { defineComponent } from 'vue';
import TeamMate from '../components/teamMate.vue';

export default defineComponent({
  name: "CaptainView",
  components: {
    TeamMate,
  },
  data() {
    return {
      teamMates: [] as TeamMateType[],
    };
  },
  async created() {
    const id = 1; // team Id to retreive
    this.teamMates = await teamMateService.getAllWithinTeam(id);
  },
});
</script>