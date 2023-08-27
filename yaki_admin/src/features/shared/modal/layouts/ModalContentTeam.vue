<script setup lang="ts">
import modalState from "@/features/shared/modal/services/modalState";
import {MODALMODE} from "@/features/shared/modal/services/modalMode";
import ModalListDropDown from "@/features/shared/modal/component/ModalListDropDown.vue";

const setTeamName = (e: Event) => {
  let input = (e.target as HTMLInputElement).value;
  modalState.setTeamInputValue(input.toString());
};
</script>

<template>
  <article class="modal-content-container input-container">
    <label>{{ modalState.mode === MODALMODE.teamEdit ? "Team name edition" : "Create a Team" }} </label>

    <input
      class="input-general"
      placeholder="team name..."
      :value="modalState.teamInputValue"
      @input="setTeamName"
      type="text" />
    <div v-if="modalState.mode === MODALMODE.teamCreateCustomer">
      <modal-list-drop-down />
    </div>
  </article>
</template>

<style scoped lang="scss">
article {
  border-top-right-radius: $modal-border-radius;
  border-top-left-radius: $modal-border-radius;

  display: flex;
  flex-direction: column;
  flex-grow: 1;
}

.input-container {
  padding-block: 2rem;
  gap: 1rem;

  label {
    color: $font-color-main-text;
    font-size: 1rem;
    font-weight: 900;
  }

  input {
    width: 50%;
    padding-inline-start: 1rem;
    padding-block: 1rem;
  }
}
</style>
