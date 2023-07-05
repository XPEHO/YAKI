<script setup lang="ts">
import isTeamSelected from "../services/isActiveTeam";
import editIcon from "@/assets/Edit.png";
import deleteIcon from "@/assets/Delete.png";
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
  modalState.changeVisibility();
};

const onClickDeleteTeam = () => {
  modalState.setModalMode(2);
  modalState.changeVisibility();
};
</script>

<template>
  <article
    class="team-list-unit"
    :class="{
      'team-list-unit-selected': isTeamSelected.isSameIndex(props.id),
    }">
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
