<script setup lang="ts">
import router from "@/router/router";
import {onBeforeMount, reactive} from "vue";

import type {UserWithIdType} from "@/models/userWithId.type";
import {usersService} from "@/services/users.service";

import isTeamSelected from "@/features/captain/services/isActiveTeam";
import UserComponent from "@/features/invitation/components/UserComponent.vue";
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import backIcon from "@/assets/arrow-back.png";
import {useTeamStore} from "@/stores/teamStore";

const teamStore = useTeamStore();

const users = reactive({
  list: [] as UserWithIdType[],
});

onBeforeMount(async () => {
  users.list = await usersService.fetchUserInRange(151, 162);
});

// invit button from user-component
const addUserToTeam = async (userId: number) => {
  teamStore.addUserToTeam(userId);
};
</script>

<template>
  <section class="main_wrapper">
    <div class="invitation__container">
      <article class="header">
        <h1 class="title">Invite Teammate</h1>
        <h2 class="text">Select the teammate(s) you want to invit to : {{ isTeamSelected.name }}</h2>
        <hr class="line" />
      </article>

      <side-bar-button
        v-bind:inner-text="'Return to teammate list'"
        v-bind:icon-path="backIcon"
        @click.prevent="router.go(-1)" />

      <div class="user_list_container">
        <user-component
          v-for="user in users.list"
          v-bind:key="user.id"
          class="user_unit"
          v-bind:user="user"
          v-bind:isInTeam="false"
          @GetUserId="addUserToTeam" />
      </div>
    </div>
  </section>
</template>

<style lang="scss">
.main_wrapper {
  display: flex;
  justify-content: center;

  .invitation__container {
    display: flex;
    flex-direction: column;
    align-items: center;

    width: 95%;
    padding-block: 30px;

    gap: 0.2rem;
  }
}

.header {
  width: 100%;
  display: flex;
  flex-direction: column;
  align-items: flex-start;

  .title {
    font-size: 38px;
  }
  .text {
    font-size: 18px;
    color: #787878;
    margin-bottom: 20px;
  }
  .line {
    width: 80%;
    background-color: #efefefed;
  }
}

.user_list_container {
  width: 65%;
  padding-block-start: 2rem;

  display: flex;
  flex-direction: column;
  gap: 1.2rem;
}
</style>
