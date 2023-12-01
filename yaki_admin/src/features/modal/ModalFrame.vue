<script setup lang="ts">
import router from "@/router/router";
import ModalCreateEditTeam from "@/components/ModalCreateEditTeam.vue";
import ModalDelete from "@/components/ModalDelete.vue";
import {useModalStore} from "@/stores/modalStore";
import {isATeamType} from "@/models/team.type";
import {MODALMODE} from "@/constants/modalMode";
import {TEAMPARAMS} from "@/constants/pathParam";

const modalStore = useModalStore();

const onCancel = () => {
  modalStore.switchModalVisibility(false, null);
};

/**
 * When a modal is validated.
 * Trigger the onMdodalChoiceValidation method of the modalStore.
 * Given the result type and modal mode, redirect to the right page.
 *
 * * If the current page is team/empty or team/deleted, redirect to /manage-team after a team creation.
 * * After a team deletion, redirect to team/deleted.
 *
 */
const onAccept = async () => {
  const result = await modalStore.onModalChoiceValidation();
  modalStore.switchModalVisibility(false, null);

  if (isATeamType(result)) {
    const currentPath = router.currentRoute.value.path;
    if (
      modalStore.getMode === MODALMODE.teamCreate &&
      (currentPath === `/dashboard/team/${TEAMPARAMS.empty}` || currentPath === `/dashboard/team/${TEAMPARAMS.deleted}`)
    ) {
      router.push({path: "/dashboard/manage-team"});
    } else if (modalStore.getMode === MODALMODE.teamDelete) {
      router.push({path: `/dashboard/team/${TEAMPARAMS.deleted}`});
    }
  }
};
</script>

<template>
  <section class="modal-background">
    <dialog class="modal-container">
      <modal-create-edit-team
        @on-accept="onAccept"
        @on-cancel="onCancel"
        v-if="modalStore.getMode === MODALMODE.teamCreate || modalStore.getMode === MODALMODE.teamEdit" />
      <modal-delete
        @on-accept="onAccept"
        @on-cancel="onCancel"
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
