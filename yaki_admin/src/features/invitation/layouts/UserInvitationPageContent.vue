<script setup lang="ts">
import { onBeforeMount, reactive } from "vue";

import type { UserWithIdType } from "@/models/userWithId.type";

import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import InvitationViewHeader from "@/features/invitation/components/InvitationViewHeader.vue";
import UserInvitationList from "@/features/invitation/components/UserInvitationList.vue";

import { useRoute } from "vue-router";
import { INVITEDROLE } from "@/constants/pathParam.enum";
import { useSelectedRoleStore } from "@/stores/selectedRole";
import { useTeammateStore } from "@/stores/teammateStore";
import { useCaptainStore } from "@/stores/captainStore";

import chevronLeftIcon from "@/assets/icons_svg/Chevron-left.svg";
import chevronRightIcon from "@/assets/icons_svg/Chevron-right.svg";
import { useUserStore } from "@/stores/userStore";

const route = useRoute();
const invitationRole = route.params.role as INVITEDROLE;

const selectedRoleStore = useSelectedRoleStore();
const teammateStore = useTeammateStore();
const captainStore = useCaptainStore();
const userStore = useUserStore();

const props = reactive({
  userList: [] as UserWithIdType[],
  fromRoute: "" as string,
  alreadInvitedUsers: [] as number[],
});
//list of person who have admin rights in company
//don't want to fetch them in each separated component

const getListOfUserAlreadyAccepted = async (invitedRole: string) => {
  if (invitedRole == INVITEDROLE.teammate) {
    return teammateStore.getTeammateList.map((teammate) => teammate.id);
  }
  if (invitedRole == INVITEDROLE.captain) {
    return captainStore.getCaptainList.map((captain) => captain.id);
  }
  return [];
};

onBeforeMount(async () => {
  props.alreadInvitedUsers = await getListOfUserAlreadyAccepted(invitationRole);

  await userStore.getUsersByPage();
  props.userList = userStore.getUsers;
});

const onUserInvitation = (invitedUser: UserWithIdType) => {
  if (invitationRole === INVITEDROLE.teammate) {
    teammateStore.addTeammateToTeam(invitedUser.id);
  }
  if (invitationRole === INVITEDROLE.captain) {
    selectedRoleStore.addCaptainToCompany(invitedUser.id);
  }
};

const nextPage = async () => {
  userStore.setPageNumber(userStore.getPageNumber + 1);

  await userStore.getUsersByPage();
  //because Vue3 reactivity need to use splice to update the list
  props.userList.splice(0, props.userList.length, ...userStore.getUsers);
};

const previewPage = async () => {
  userStore.setPageNumber(userStore.getPageNumber - 1);

  await userStore.getUsersByPage();
  //because Vue3 reactivity need to use splice to update the list
  props.userList.splice(0, props.userList.length, ...userStore.getUsers);
};
</script>
<template>
  <page-content-layout>
    <template #pageContentHeader>
      <invitation-view-header v-bind:invited-role="invitationRole" />
    </template>

    <template #content>
      <user-invitation-list
        v-if="props.userList && props.userList.length > 0"
        :userList="props.userList"
        :invitedUsers="props.alreadInvitedUsers"
        :testprops="'test de props'"
        @emittedUserInvitation="onUserInvitation"
      />
    </template>
  </page-content-layout>

  <section class="page_handling__container">
    <button
      class="page_count_button"
      @click.prevent="previewPage"
      :style="userStore.getPageNumber === 0 ? 'pointer-events: none; opacity: 0.2;' : ''"
    >
      <figure>
        <img
          :src="chevronLeftIcon"
          alt=""
        />
      </figure>
    </button>

    <div>
      <p>Page : {{ userStore.getPageNumber + 1 }} / {{ userStore.getTotalPagesCount }}</p>
    </div>

    <button
      class="page_count_button"
      @click.prevent="nextPage"
      :style="
        userStore.getPageNumber === userStore.getTotalPagesCount - 1
          ? 'pointer-events: none; opacity: 0.2;'
          : ''
      "
    >
      <figure>
        <img
          :src="chevronRightIcon"
          alt=""
        />
      </figure>
    </button>
  </section>
</template>

<style scoped lang="scss">
.page_handling__container {
  position: absolute;
  bottom: 0;

  width: 95%;
  height: 80px;
  margin-inline: 1rem;

  display: flex;
  justify-content: center;
  align-items: center;
  gap: 3rem;

  $size: 40px;

  background-color: $background-color-theme-primary;

  figure {
    width: $size;
    height: $size;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }

  p {
    font-family: $font-sf-pro;
  }

  .page_count_button {
    border: none;
    background-color: transparent;

    &:hover {
      cursor: pointer;
    }

    &:active {
      transform: scale(0.9);
    }
  }
}
</style>
