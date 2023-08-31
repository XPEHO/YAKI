<script setup lang="ts">
import modalState from "@/features/shared/modal/services/modalState";
import {MODALMODE} from "@/features/shared/modal/services/modalMode";

const changeTitle = () => {
  switch (modalState.mode) {
    case MODALMODE.teamDelete:
      return modalState.teamName;
    case MODALMODE.userDelete:
      return modalState.UserFirstLastName;
  }
};

const changeSubText = () => {
  switch (modalState.mode) {
    case MODALMODE.teamDelete:
      return "Is going to be deleted";
    case MODALMODE.userDelete:
      return "Is going to be removed from the team";
  }
};
</script>

<template>
  <article class="modal-content-container modal-text">
    <p class="modal-title-text">
      {{ changeTitle() }}
    </p>
    <p class="modal-sub-text">
      {{ changeSubText() }}
    </p>
  </article>
</template>

<style scoped lang="scss">
.modal-text {
  gap: 0.25rem;

  p {
    width: 65%;
    text-align: center;
  }

  p:nth-child(1) {
    padding-block: 0.5rem;
  }

  p:nth-child(2) {
    padding-block: 0.5rem;
  }
}
</style>
