<script setup lang="ts">
import { useTeamStore } from "@/stores/teamStore";

const teamStore = useTeamStore();

const props = defineProps({
  id: {
    type: Number,
    required: true,
  },
  teamName: {
    type: String,
    required: true,
  },
});

const classList = [
  "text-icon__container",
  "drop-down__menu_item--height-padding-color unselectabla-text",
  "text-icon--text",
  "text-wrap",
];
</script>

<template>
  <p :class="[classList, { 'team-selected': teamStore.isSameTeamId(props.id) }]">
    {{ props.teamName }}
  </p>
</template>

<style scoped lang="scss">
.team-selected {
  padding-inline-start: 16px;
  background-color: #ffffff;

  &:hover {
    background-color: #f0eeee;
  }
}

.text-wrap {
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
