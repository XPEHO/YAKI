<script setup lang="ts">
import router from "@/router/router";
import {onBeforeMount, reactive} from "vue";
import {useTeamStore} from "@/stores/teamStore";
import {environmentVar} from "@/envPlaceholder";

import type {UserWithIdType} from "@/models/userWithId.type";
import {usersService} from "@/services/users.service";

import UserComponent from "@/features/invitation/components/UserComponent.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import HeaderContentPage from "@/features/shared/components/HeaderContentPage.vue";
import backIcon from "@/assets/arrow-back.png";

const teamStore = useTeamStore();

const users = reactive({
  list: [] as UserWithIdType[],
});

onBeforeMount(async () => {
  users.list = await usersService.fetchUserInRange(
    environmentVar.tempUserIdRangeStart,
    environmentVar.tempUserIdRAngeEnd
  );
});

// invit button from user-component
const addUserToTeam = async (userId: number) => {
  teamStore.addUserToTeam(userId);
};
</script>

<template>
  <section class="main_wrapper">
    <header-content-page
      v-bind:title="'Invite Teammate'"
      v-bind:text="'Select the teammate(s) you want to invit to : ' + teamStore.getTeamName" />

    <side-bar-button
      v-bind:inner-text="'Return to teammate list'"
      v-bind:icon-path="backIcon"
      @click.prevent="router.go(-1)" />

    <section class="user_list_container">
      <user-component
        v-for="user in users.list"
        v-bind:key="user.id"
        class="user_unit"
        v-bind:user="user"
        v-bind:isInTeam="false"
        @GetUserId="addUserToTeam" />
    </section>
  </section>
</template>

<style lang="scss">
.main_wrapper {
  padding: 30px;
}

.user_list_container {
  margin-inline: auto;
  width: 65%;
  padding: 50px;

  display: flex;
  flex-direction: column;
  gap: 1.2rem;
}
</style>
@/features/captain/services/isSelectedTeamActive
