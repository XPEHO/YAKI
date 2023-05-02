<template>
  <div class="captainView">
    <h1 class="title">Team Members</h1>
    <h2 class="text">Manage your team members here</h2>
    <hr class="line">
    <ul class="teamMateList">
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

<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300&display=swap');

.captainView {
  font-family: 'Inter', sans-serif;
}
.title {
  font-size: 48px;
}
.text{
  font-size: 20px;
  color: #787878;
  margin-bottom: 20px;
}
.line{
  width: 50%;
  background-color: #E5E5E5;

margin: 0px;
}
.teamMateList{ 
  list-style-type: none;
}
</style>