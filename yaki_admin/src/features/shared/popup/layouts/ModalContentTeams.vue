<script setup lang="ts">
import modalState from "@/features/shared/services/modalState";
import {MODALMODE} from "@/features/shared/services/modalMode";
import {computed, inject, nextTick, ref, watch} from "vue";

const setTeamName = (e: Event) => {
  let input = (e.target as HTMLInputElement).value;
  modalState.setTeamInputValue(input.toString());
};
</script>

<template>
  <article
    v-if="modalState.mode === MODALMODE.teamCreate || modalState.mode === MODALMODE.teamEdit"
    class="modal-content-container input-container">
    <label>{{ modalState.mode === MODALMODE.teamCreate ? "Create a Team" : "Team name edition : " }} </label>
    <input
      placeholder="team name..."
      :value="modalState.teamInputValue"
      @input="setTeamName"
      type="text" />
  </article>

  <article
    v-else-if="modalState.mode === MODALMODE.teamDelete"
    class="modal-content-container input-container">
    <p>{{ modalState.teamName }}</p>
    <p>Is going to be deleted</p>
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
  gap: 0.7rem;

  label,
  p {
    color: $font-color-main-text;
    font-size: 1.1rem;
    font-weight: 900;
  }

  p:nth-of-type(2) {
    padding-block: 0.5rem;
    font-size: 15px;
    color: $font-color-sub-text;
  }

  input {
    width: 50%;

    border-radius: 1rem;
    border: none;

    font-size: 1rem;
    font-weight: 400;

    padding-inline-start: 1rem;
    padding-block: 1rem;
    &:focus {
      outline: 1px solid rgb(21, 21, 21);
    }
  }
}
</style>
