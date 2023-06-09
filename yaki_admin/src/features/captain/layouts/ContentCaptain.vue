<script lang="ts">
// Importing necessary modules and types
import {useTeamStore} from "@/stores/teamStore.js";
import {defineComponent} from "vue";
import TeamMate from "../components/teamMate.vue";
import type {TeamMateType} from "@/services/teamMate.type";

// Defining the Vue component
export default defineComponent({
  name: "CaptainView",
  // The components that this component uses
  components: {
    TeamMate,
  },
  computed: {
    teamStore() {
      return useTeamStore();
    },
  },
});
</script>

<template>
  <div class="captain-view">
    <h1 class="title">Team Members</h1>
    <h2 class="text">Manage your team members here</h2>
    <hr class="line" />
    <ul class="team-mate-list">
      <li
        v-for="teamMate in (teamStore.teammate as TeamMateType[])"
        :key="teamMate.id">
        <team-mate :team-mate="teamMate" />
      </li>
    </ul>
  </div>
</template>

<style lang="scss">
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300&display=swap");

.captain-view {
  margin: 10px;
  padding: 20px;
  font-family: "Inter", sans-serif;
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
  background-color: #e5e5e5;

  margin: 0px;
}
.team-mate-list {
  padding: 50px;
  list-style-type: none;
  display: flex;
  flex-direction: column;
  align-items: center;
}
</style>
