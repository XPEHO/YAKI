<script setup lang="ts">
import isTeamSelected from "@/features/shared/services/isSelectedTeamActive";
import editIcon from "@/assets/images/Edit.png";
import deleteIcon from "@/assets/images/Delete.png";
import modalState from "@/features/shared/services/modalTeamState";

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
  modalState.setModalMode(1);
  modalState.visibilitySwitch();
};

const onClickDeleteTeam = () => {
  modalState.setModalMode(2);
  modalState.visibilitySwitch();
};
</script>

<template>
  <article
    class="team-list-unit"
    :class="{
      'team-list-unit-selected': isTeamSelected.isSameTeamId(props.id),
    }">
    <p>{{ props.teamName }}</p>
    <section class="delete-edit-icon">
      <button @click="onClickEditTeam">
        <figure>
          <img
            class="teammate-icon"
            v-bind:src="editIcon"
            alt="" />
        </figure>
      </button>
      <button @click="onClickDeleteTeam">
        <figure>
          <img
            class="teammate-icon"
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
  justify-content: space-around;
  align-items: center;
  gap: 1.25rem;

  width: 100%;
  padding-block: 0.5rem;

  p {
    width: 40%;
    font-size: 0.95rem;
    user-select: none;
  }

  .delete-edit-icon {
    button {
      border: none;
      background-color: transparent;

      &:active {
        transform: scale(0.95);
      }

      figure {
        width: 1.3rem;
        .teammate-icon {
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
@/features/shared/services/isSelectedTeamActive
