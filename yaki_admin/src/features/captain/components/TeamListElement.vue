<script setup lang="ts">
import isTeamSelected from "../services/isActiveTeam";
import editIcon from "@/assets/Edit.png";
import deleteIcon from "@/assets/Delete.png";

const props = defineProps({
  teamName: {
    type: String,
    required: true,
  },
});
</script>

<template>
  <article
    class="team-list-unit"
    :class="{'team-list-unit-selected': isTeamSelected.isSameIndex(props.teamName)}">
    <p>{{ teamName }}</p>
    <figure>
      <img v-bind:src="editIcon" />
    </figure>
    <figure>
      <img v-bind:src="deleteIcon" />
    </figure>
  </article>
</template>

<style lang="scss">
.team-list-unit {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1.25rem;

  width: 100%;
  padding-block: 0.5rem;

  p {
    font-size: 0.95rem;
    user-select: none;
  }

  figure {
    width: 1.3rem;

    img {
      user-select: none;
      width: 100%;
      object-fit: cover;
    }
  }

  &:hover {
    cursor: pointer;
  }
}

.team-list-unit-selected {
  background-color: #f5cd3d;
}
</style>
