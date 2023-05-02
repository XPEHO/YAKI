<script setup lang="ts">
import {reactive} from "vue";
import AddTeamButton from "@/shared/components/AddTeamButton.vue";

const teams = reactive({
  list: [1, 2, 3, 4, 5],
});

const addTeam = () => {
  teams.list.push(teams.list.length + 1);
};
</script>

<template>
  <p>My Team</p>

  <div v-for="number in teams.list">{{ number }}</div>

  <AddTeamButton />
</template>

<style lang="scss">
p {
  text-decoration: none;
  color: rgb(186, 182, 182);
  font-size: 1.2rem;
  font-weight: 900;
}
</style>
