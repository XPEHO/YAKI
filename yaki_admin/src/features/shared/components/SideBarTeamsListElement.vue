<script setup lang="ts">
import editIcon from "@/assets/images/Edit.png";
import deleteIcon from "@/assets/images/Delete.png";
import modalState from "@/features/shared/modal/services/modalState";
import {useTeamStore} from "@/stores/teamStore";
import {MODALMODE} from "@/features/shared/modal/services/modalMode";

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

const onClickEditTeam = () => {
  // change input value on edit to have the current team name to edit
  modalState.switchModalVisibility(true, MODALMODE.teamEdit, props.teamName);
};

const onClickDeleteTeam = () => {
  modalState.setTeamName(props.teamName);
  modalState.switchModalVisibility(true, MODALMODE.teamDelete);
};
</script>

<template>
  <article
    :class="[
      'team-list-unit',
      {
        'team-list-unit-selected': teamStore.isSameTeamId(props.id),
      },
    ]">
    <p>{{ props.teamName }}</p>
    <section class="delete-edit-icon">
      <button @click="onClickEditTeam">
        <figure>
          <img
            class="team-mate-icon"
            v-bind:src="editIcon"
            alt="" />
        </figure>
      </button>
      <button @click="onClickDeleteTeam">
        <figure>
          <img
            class="team-mate-icon"
            v-bind:src="deleteIcon"
            alt="" />
        </figure>
      </button>
    </section>
  </article>
</template>

<style lang="scss">
.team-list-unit {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 0.5rem;

  width: 100%;
  padding-block: 0.5rem;

  p {
    width: 40%;
    font-size: $font-size-sidebar-teamlist-element;
    user-select: none;
  }

  .delete-edit-icon {
    display: flex;
    gap: 1.2rem;
    button {
      border: none;
      background-color: transparent;

      &:active {
        transform: scale(0.95);
      }

      figure {
        width: 1.3rem;
        .team-mate-icon {
          width: 100%;
          object-fit: contain;
        }
      }
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
@/features/shared/modal/services/modalState@/features/shared/modal/services/modalMode
