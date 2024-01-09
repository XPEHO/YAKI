<script setup lang="ts">
import router from "@/router/router";
import { onMounted, reactive } from "vue";
import { useRoleStore } from "@/stores/roleStore";

import SideBarMenuLink from "@/ui/components/sidebar/SideBarMenuLink.vue";
import sideBarMenuDropDown from "@/ui/components/sidebar/SideBarMenuDropDown.vue";
import LoggedUserCard from "@/ui/components/LoggedUserCard.vue";

import Banner from "@/assets/images/YAKISquare.svg";
import caseIcon from "@/assets/icons_svg/Briefcase.svg";
import hatIcon from "@/assets/icons_svg/Boat.svg";
import statIcon from "@/assets/icons_svg/Statistic.svg";

const roleStoreTest = useRoleStore();

const userCredentials = reactive({
  owner: false as boolean,
  customer: false as boolean,
  captain: false as boolean,
});

onMounted(() => {
  userCredentials.customer = roleStoreTest.customersIdWhereIgotRights.length > 0;
  userCredentials.captain = roleStoreTest.captainsId.length > 0;
});

const redirection = (path: string) => {
  if (path.includes("statistics")) {
    router.push("/dashboard/statistics");
    return;
  }
  if (path.includes("manage-captains") && userCredentials.customer) {
    router.push("/dashboard/manage-captains");
    return;
  }
};
</script>

<template>
  <nav class="sidebar__container">
    <div>
      <figure>
        <img
          :src="Banner"
          alt=""
        />
      </figure>

      <side-bar-menu-link
        v-if="userCredentials.owner"
        :icon="caseIcon"
        text="Clients"
      />
      <side-bar-menu-link
        v-if="userCredentials.customer"
        @click.prevent="redirection('/dashboard/manage-captains')"
        :icon="hatIcon"
        text="Captains"
      />
      <side-bar-menu-drop-down
        v-if="userCredentials.captain"
        inner-text="My teams"
        icon-path="groupIcon"
      />
      <side-bar-menu-link
        @click.prevent="redirection('/dashboard/statistics')"
        :icon="statIcon"
        text="Statistics"
      />
    </div>

    <div>
      <logged-user-card />
    </div>
  </nav>
</template>

<style scoped lang="scss">
.sidebar__container {
  box-sizing: border-box;
  padding: 16px;

  display: flex;
  flex-direction: column;
  justify-content: space-between;
  gap: 8px;

  background-color: $background-color-theme-secondary;

  figure {
    width: 65px;
    padding-inline-start: 16px;
    padding-block: 32px;
    img {
      width: 100%;
      object-fit: contain;
    }
  }
}
</style>
