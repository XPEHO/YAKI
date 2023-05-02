<script setup lang="ts">
import {reactive} from "vue";
import TeamListing from "./TeamListing.vue";
import SideBarSelector from "@/shared/components/SideBarSelector.vue";

const teams = reactive({
  list: ["team 1", "team 2", "team 3", "team 4", "team 5"],
});

const addTeam = () => {
  teams.list.push("team " + teams.list.length + 1);
};
</script>

<template>
  <SideBarSelector />

  <section class="team-list">
    <TeamListing
      v-for="team in teams.list"
      v-bind:teamName="team" />
  </section>
</template>

<style lang="scss"></style>
