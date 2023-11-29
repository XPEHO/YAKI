<script setup lang="ts">
import ModalCreateEditTeam from "@/components/ModalCreateEditTeam.vue";
import ModalDelete from "@/components/ModalDelete.vue";
import {MODALMODE} from "@/constants/modalMode";
import {useModalStore} from "@/stores/modalStore";

const modalStore = useModalStore();
</script>

<template>
  <section class="modal-background">
    <dialog class="modal-container">
      <modal-create-edit-team
        v-if="modalStore.getMode === MODALMODE.teamCreate || modalStore.getMode === MODALMODE.teamEdit" />
      <modal-delete
        v-else-if="modalStore.getMode === MODALMODE.teamDelete || modalStore.getMode === MODALMODE.userDelete" />
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
