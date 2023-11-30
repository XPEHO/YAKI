<script setup lang="ts">
import {useTeamStore} from "@/stores/teamStore";

const teamStore = useTeamStore();

const props = defineProps({
  teamName: {
    type: String,
    required: true,
  },
  id: {
    type: Number,
    required: true,
  },
});

const classList = ["text-icon__container", "drop-down__menu_item--height-padding-color unselectabla-text"];
</script>

<template>
  <p
    :class="[
      classList,
      {
        'team-selected': teamStore.isSameTeamId(props.id),
      },
    ]">
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
</style>
