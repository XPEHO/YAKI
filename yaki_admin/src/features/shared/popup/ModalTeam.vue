<script setup lang="ts">
import modalTeamState from "@/features/shared/services/modalTeamState";
import {useTeamStore} from "@/stores/teamStore";

const teamStore = useTeamStore();

const setTeamName = (e: Event) => {
  let input = (e.target as HTMLInputElement).value;
  modalTeamState.setTeamInputValue(input.toString());
};

const emit = defineEmits(["ModalTeam"]);

const validateModalBtn = () => {
  emit("ModalTeam", modalTeamState.teamInputValue);
  modalTeamState.changeVisibility();
};

const CancelModalBtn = () => {
  modalTeamState.changeVisibility();
};
</script>

<template>
  <section class="modal-background">
    <dialog class="modal-container">
      <form action="">
        <article
          v-if="modalTeamState.modalMode === 0 || modalTeamState.modalMode === 1"
          class="input-container">
          <label v-if="modalTeamState.modalMode === 0">Create a Team : </label>
          <label v-else-if="modalTeamState.modalMode === 1">Edit Team Name : </label>
          <input
            placeholder="team name..."
            :value="modalTeamState.teamInputValue"
            @input="setTeamName"
            type="text" />
        </article>
        <article
          v-else-if="modalTeamState.modalMode === 2"
          class="input-container">
          <p>Delete : {{ teamStore.getTeamName }} ?</p>
        </article>
        <section>
          <button @click.prevent="validateModalBtn">Confirm</button>
          <button @click.prevent="CancelModalBtn">Cancel</button>
        </section>
      </form>
    </dialog>
  </section>
</template>

<style scoped lang="scss">
form {
  display: flex;
  flex-direction: column;
  flex-grow: 1;

  .input-container {
    flex-grow: 3;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    gap: 1.5rem;

    background-color: #cac9c9;

    label,
    p {
      color: #303030;
      font-size: 1.3rem;
      font-family: Inter;
      font-weight: 700;
    }

    input {
      height: 2.5rem;
      width: 50%;

      border-radius: 0.2rem;
      border: none;

      font-size: 1rem;
      font-weight: 400;

      padding-inline-start: 1rem;
      &:focus {
        outline: 1px solid rgb(21, 21, 21);
      }
    }
  }
}

section {
  flex-grow: 1;
  width: 100%;

  display: flex;
  button {
    border: none;
    flex-grow: 1;
  }

  button:nth-child(1) {
    background-color: #a2b75e;
    &:active {
      background-color: #899b4d;
    }
  }

  button:nth-child(2) {
    background-color: #dd6158;
    &:active {
      background-color: #b24c45;
    }
  }
}
</style>
