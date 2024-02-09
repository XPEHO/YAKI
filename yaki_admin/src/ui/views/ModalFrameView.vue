<script setup lang="ts">
import router from "@/router/router";
import ModalCreateEditTeam from "@/ui/components/modals/ModalCreateEditTeam.vue";
import ModalDelete from "@/ui/components/modals/ModalDelete.vue";
import ModalComingSoon from "@/ui/components/modals/ModalComingSoon.vue";
import { useModalStore } from "@/stores/modalStore";
import { isATeamType } from "@/models/team.type";
import { MODALMODE } from "@/constants/modalMode.enum";
import { TEAMPARAMS } from "@/constants/pathParam.enum";
import { useTeamStore } from "@/stores/teamStore";
import { useTeammateStore } from "@/stores/teammateStore";
import { useCaptainStore } from "@/stores/captainStore";
import { useTeamLogoStore } from "@/stores/teamLogoStore";

const modalStore = useModalStore();
const teamStore = useTeamStore();
const teammateStore = useTeammateStore();
const captainStore = useCaptainStore();
const teamLogoStore = useTeamLogoStore();

const onCancel = () => {
  modalStore.switchModalVisibility(false, null);
};

const closeModal = () => {
  modalStore.switchModalVisibility(false, null);
};

/**
 * Handles the modal accept action.
 * Depending on the current modal mode,
 * it either
 * * deletes a user,
 * * deletes a captain,
 * * or performs create / update / delete a team.
 *
 * @returns {Promise} The result of the async operation. The specific result depends on the modal mode:
 * - If the modal mode is 'userDelete', it returns the result of deleting a teammate from the team.
 * - If the modal mode is 'captainDelete', it returns the result of deleting a captain.
 * - Otherwise, it returns the result of performing CRUD operations on a team.
 */
const restActions = async () => {
  const isUserToBeDeleted = modalStore.getMode === MODALMODE.userDelete;
  const isCaptainToBeDeleted = modalStore.getMode === MODALMODE.captainDelete;

  if (isUserToBeDeleted) {
    return await teammateStore.deleteTeammateFromTeam();
  } else if (isCaptainToBeDeleted) {
    return await captainStore.removeCaptainRight();
  } else {
    return await teamStore.crudOperations();
  }
};

/**
 * Handles the team logo.
 * If the modal mode is 'teamEdit', it either
 * * deletes the logo if the user wants to delete it,
 * * or creates / updates the logo if the user wants to keep it.
 * If the modal mode is 'teamDelete', it deletes the logo.
 */
const handleTeamLogo = () => {
  if (modalStore.getMode === MODALMODE.teamEdit) {
    if (teamLogoStore.getIsLogoToBeDeleted) {
      teamLogoStore.delete();
    } else {
      teamLogoStore.createOrUpdate();
    }
  }
  if (modalStore.getMode === MODALMODE.teamDelete) teamLogoStore.delete();
};

const handleRedirect = (result: any) => {
  if (isATeamType(result)) {
    const currentPath = router.currentRoute.value.path;
    if (
      modalStore.getMode === MODALMODE.teamCreate &&
      (currentPath === `/dashboard/team/${TEAMPARAMS.empty}` ||
        currentPath === `/dashboard/team/${TEAMPARAMS.deleted}`)
    ) {
      router.push({ path: "/dashboard/manage-team" });
    } else if (modalStore.getMode === MODALMODE.teamDelete) {
      router.push({ path: `/dashboard/team/${TEAMPARAMS.deleted}` });
    }
  }
};

/**
 * At modal accept validation.
 */
const onAccept = async () => {
  const result = restActions();
  handleTeamLogo();

  modalStore.switchModalVisibility(false, null);

  handleRedirect(result);
};
</script>

<template>
  <section class="modal-background">
    <dialog class="modal-container">
      <modal-create-edit-team
        @on-accept="onAccept"
        @on-cancel="onCancel"
        v-if="
          modalStore.getMode === MODALMODE.teamCreate || modalStore.getMode === MODALMODE.teamEdit
        "
      />
      <modal-delete
        @on-accept="onAccept"
        @on-cancel="onCancel"
        v-else-if="
          modalStore.getMode === MODALMODE.teamDelete ||
          modalStore.getMode === MODALMODE.userDelete ||
          modalStore.getMode === MODALMODE.captainDelete
        "
      />
      <modal-coming-soon
        @close="closeModal"
        v-else-if="modalStore.getMode === MODALMODE.comingSoon"
      />
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
