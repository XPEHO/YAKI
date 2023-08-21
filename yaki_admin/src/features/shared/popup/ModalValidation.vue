<script setup lang="ts">
import modalValidationState from "@/features/shared/services/modalValidationState";

const emit = defineEmits(["ModalAccept"]);

const validateModalBtn = () => {
  emit("ModalAccept");
  modalValidationState.changeVisibility();
};

const CancelModalBtn = () => {
  modalValidationState.changeVisibility();
};
</script>

<template>
  <section class="modal-background">
    <dialog class="modal-container">
      <article class="modal-text">
        <p>Do you want to remove :</p>
        <p>{{ modalValidationState.information }}</p>
        <p>from the team ?</p>
      </article>
      <section>
        <button @click.prevent="validateModalBtn">Confirm</button>
        <button @click.prevent="CancelModalBtn">Cancel</button>
      </section>
    </dialog>
  </section>
</template>

<style scoped lang="scss">
.modal-text {
  flex-grow: 3;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 0.25rem;

  background-color: #cac9c9;

  p {
    width: 65%;

    color: #303030;
    font-size: 1rem;
    font-family: Inter;
    font-weight: 700;
    text-align: center;
  }

  p:nth-child(2) {
    padding-block: 0.5rem;
    color: #0b0b0b;
    font-size: 1.2rem;
    font-weight: bolder;
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
@/features/shared/services/modalValidationState
