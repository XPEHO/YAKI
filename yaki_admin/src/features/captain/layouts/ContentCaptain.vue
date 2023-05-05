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
// Importing necessary modules and types
import { teamMateService } from '../../../services/teamMate.service'
import type { TeamMateType } from '../../../services/teamMate.type';
import { defineComponent } from 'vue';
import TeamMate from '../components/teamMate.vue';
// Defining the Vue component
export default defineComponent({
  name: "CaptainView",
  // The components that this component uses
  components: {
    TeamMate,
  },
  data() {
    return {
      teamMates: [] as TeamMateType[],// An empty array of team mates
    };
  },
  async created() {
    const id = 1; // team Id to retreive
    this.teamMates = await teamMateService.getAllWithinTeam(id);// Retrieve the team mates for the given ID
  },
});
</script>

<style lang="scss">
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300&display=swap');

.captainView {
  margin: 10px;
  padding: 20px;
  font-family: 'Inter', sans-serif;
}

.title {
  font-size: 38px;
}
.text {
  font-size: 18px;
  color: #787878;
  margin-bottom: 20px;
}
.line {
  width: 70%;
  background-color: #E5E5E5;

  margin: 0px;
}
.teamMateList {
  padding: 50px;
  list-style-type: none;
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>

