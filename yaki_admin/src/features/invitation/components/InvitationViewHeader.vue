<script setup lang="ts">
import buttonTextIcon from "@/ui/components/buttons/ButtonTextIcon.vue";
import backIcon from "@/assets/icons_svg/Arrow-left.svg";

import router from "@/router/router";

import { useTeamStore } from "@/stores/teamStore";
import { INVITEDROLE } from "@/constants/pathParam.enum";

const teamStore = useTeamStore();

defineProps({
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
</script>

<template>
  <section class="header__container_invitation">
    <div>
      <section>
        <h1 class="text_default__title_header">
          {{
            invitedRole === INVITEDROLE.teammate
              ? $t("header.teammateInvitation")
              : $t("header.captainInvitation")
          }}
        </h1>

        <p v-if="invitedRole === INVITEDROLE.teammate">
          {{ $t("header.teammateAddedTo") }} <span>{{ teamStore.getTeamSelected.teamName }}</span>
        </p>
        <p v-if="invitedRole === INVITEDROLE.captain">{{ $t("header.captainInvitComment") }}</p>
      </section>

      <button-text-icon
        @click.prevent="router.go(-1)"
        :icon="backIcon"
        :text="$t('buttons.return')"
        color="button--color-secondary"
      />
    </div>
  </section>
</template>

<style scoped lang="scss">
.header__container_invitation {
  display: flex;
  flex-direction: column;
  gap: 16px;

  padding-block: 44px 24px;
  padding-inline: 40px;

  > div {
    display: flex;
    align-items: flex-start;
    justify-content: space-between;
    width: 100%;
    //figure & text
    > section:nth-of-type(1) {
      display: flex;
      flex-direction: column;
      gap: 16px;

      p {
        padding-inline-start: 1rem;
        color: #7d818c;
        font-family: Rubik, sans-serif;
        font-size: 16px;
        font-weight: 400;

        span {
          font-size: 18px;
          font-weight: 600;
        }
      }
    }
  }
}
</style>
