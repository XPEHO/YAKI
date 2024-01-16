<script setup lang="ts">
import buttonTextIcon from "@/ui/components/buttons/ButtonTextIcon.vue";
import buttonIcon from "@/ui/components/buttons/ButtonIcon.vue";
import addIcon from "@/assets/icons_svg/AddPlus.svg";
import dotIcon from "@/assets/icons_svg/3dots.svg";

import router from "@/router/router";

import modalTeamEditDelete from "@/ui/components/modals/ModalTeamEditDelete.vue";
import { useTeamStore } from "@/stores/teamStore";
import { useModalToggleWithOutsideClickHandler } from "@/composable/useModalToggleWithOutsideClickHandler";
import { computed } from "vue";
import { INVITEDROLE } from "@/constants/pathParam.enum";
import { setTeamLogoUrl } from "@/utils/images.utils";

const teamStore = useTeamStore();

const props = defineProps({
  /**
   * Display specific elements related to team management if true
   * @values true, false, default value is false.
   */
  isTeamManagement: {
    type: Boolean,
    default: false,
  },
  /**
   * Role of the invited user,
   * used to display the correct title.
   * And determine the path to redirect to when clicking on the invitation button.
   * using the INVITEDROLE enum, as value.
   */
  invitedRole: {
    type: String as () => INVITEDROLE,
    required: true,
  },
});

const title = computed(() => {
  switch (props.invitedRole) {
    case INVITEDROLE.captain:
      return "Captain management";
    case INVITEDROLE.teammate:
      return teamStore.getTeamSelected.teamName;
    default:
      return "";
  }
});

const { isModalVisible, switchModalVisibility } = useModalToggleWithOutsideClickHandler(
  ".modal-edit-delete__container",
  ".button-icon-selector",
);
</script>

<template>
  <section class="header__container">
    <div>
      <section>
        <figure v-if="isTeamManagement">
          <img
            :src="setTeamLogoUrl(teamStore.getTeamSelectedLogo.teamLogoBlob)"
            alt=""
          />
        </figure>
        <h1 class="text_default__title_header">{{ title }}</h1>
      </section>

      <section class="header__buttons-modal_container">
        <button-text-icon
          @click.prevent="router.push({ path: `invitation/${invitedRole}` })"
          :icon="addIcon"
          text="INVITATION"
        />

        <button-icon
          v-if="isTeamManagement"
          :icon="dotIcon"
          class="button-icon-selector"
          @click.prevent="switchModalVisibility"
        />

        <div
          v-if="isTeamManagement"
          :class="[
            'modal-edit-delete__container',
            isModalVisible ? 'modal-edit-delete__visible' : 'modal-edit-delete__hidden',
          ]"
        >
          <modal-team-edit-delete @on-choice-selection="switchModalVisibility" />
        </div>
      </section>
    </div>
  </section>
</template>

<style scoped lang="scss">
.header__container {
  display: flex;
  flex-direction: column;
  gap: 16px;

  padding-block: 44px 24px;
  padding-inline: 40px;

  figure {
    width: 48px;
    height: 48px;
    border-radius: 16px;
    img {
      width: 100%;
      object-fit: contain;
      border-radius: 16px;
    }
  }

  > div {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    //figure & text
    > section:nth-of-type(1) {
      display: flex;
      align-items: center;
      gap: 8px;
    }
  }
  .header__buttons-modal_container {
    display: flex;
    align-items: center;
    gap: 16px;

    position: relative;

    .modal-edit-delete__container {
      position: absolute;
      top: 130%;
      right: 0;
      transition:
        visibility 0.15s,
        opacity 0.15s ease;
    }
    .modal-edit-delete__hidden {
      visibility: hidden;
      opacity: 0;
    }
    .modal-edit-delete__visible {
      visibility: visible;
      opacity: 1;
    }
  }
}
</style>
