<script setup lang="ts">
import modalState from "@/features/shared/modal/services/modalState";
import ModalContentTeam from "@/features/shared/modal/layouts/ModalContentTeam.vue";
import ModalContentDeletionValidation from "@/features/shared/modal/layouts/ModalContentDeletionValidation.vue";
import {MODALMODE} from "@/features/shared/modal/services/modalMode";
import {nextTick, watch} from "vue";

const validationModalAccept = async () => {
  modalState.validationActions();

  modalState.switchModalVisibility(false, null);
  return;
};

const CancelModalBtn = () => {
  modalState.switchModalVisibility(false, null);
};

/**
 * watch the modalState.isShowed( as need a changing value).
 *  And focus the input when the modal is open, and when creating a team or editing one.
 */
watch(
  () => modalState.isShowed,
  (newValue) => {
    if (
      (newValue === true && modalState.mode === MODALMODE.teamCreate) ||
      modalState.mode === MODALMODE.teamEdit ||
      modalState.mode === MODALMODE.teamCreateCustomer
    ) {
      nextTick(() => {
        const input = document.querySelector("input");
        input?.focus();
      });
    }
    if ((newValue === true && modalState.mode === MODALMODE.userDelete) || modalState.mode === MODALMODE.teamDelete) {
      nextTick(() => {
        const button = document.querySelector("button");
        button?.focus();
      });
    }
  }
);
</script>

<template>
  <section class="modal-background">
    <dialog class="modal-container">
      <form>
        <component
          :is="
            modalState.mode === MODALMODE.userDelete || modalState.mode === MODALMODE.teamDelete
              ? ModalContentDeletionValidation
              : ModalContentTeam
          " />

        <section class="button-container">
          <button @click.prevent="validationModalAccept">Confirm</button>
          <button @click.prevent="CancelModalBtn">Cancel</button>
        </section>
      </form>
    </dialog>
  </section>
</template>

<style scoped lang="scss">
.modal-background {
  z-index: 9000;
  // screen center even when scroll : fixed not absolute
  position: fixed;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;

  background-color: rgba(0, 0, 0, 0.515);
  .modal-container {
    left: 50%;
    top: 40%;
    transform: translate(-50%, -50%);

    border: none;
    border-radius: $modal-border-radius;

    min-height: 15rem;
    width: min(90%, 30rem);

    display: flex;

    form {
      display: flex;
      flex-direction: column;
      flex: 1;
    }
  }
}

.button-container {
  width: 100%;
  display: flex;

  button {
    border: none;
    flex-grow: 1;
    padding-block: 1.2rem;

    color: rgb(232, 232, 232);
    font-size: 0.9rem;
    letter-spacing: 1px;
    font-weight: 500;
  }

  button:nth-child(1) {
    background-color: #95ad45;
    &:active {
      background-color: #687e21;
    }
    border-bottom-left-radius: $modal-border-radius;
  }

  button:nth-child(2) {
    background-color: #c5534b;
    &:active {
      background-color: #88413c;
    }
    border-bottom-right-radius: $modal-border-radius;
  }
}
</style>
