<script setup lang="ts">
import ModalCreateEditTeam from "@/components/ModalCreateEditTeam.vue";
import modalState from "@/features/modal/services/modalState";
import ModalDelete from "@/components/ModalDelete.vue";
import {MODALMODE} from "@/constants/modalMode";
</script>

<template>
  <section class="modal-background">
    <dialog class="modal-container">
      <modal-create-edit-team
        v-if="modalState.mode === MODALMODE.teamCreate || modalState.mode === MODALMODE.teamEdit" />
      <modal-delete v-else-if="modalState.mode === MODALMODE.teamDelete || modalState.mode === MODALMODE.userDelete" />
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
    display: flex;
    left: 50%;
    top: 40%;
    transform: translate(-50%, -50%);
    border: none;
    background-color: transparent;
  }
}
</style>
../../../constants/modalMode @/constants/modalMode
