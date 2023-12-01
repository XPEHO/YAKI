<script setup lang="ts">
import SideBarMenuLink from "@/ui/components/sidebar/SideBarMenuLink.vue";
import sideBarMenuDropDown from "@/ui/components/sidebar/SideBarMenuDropDown.vue";
import LoggedUserCard from "@/ui/components/LoggedUserCard.vue";

import Banner from "@/assets/images/splashscreen.svg";
import caseIcon from "@/assets/images/briefcase-regular-24.png";
import hatIcon from "@/assets/images/hard-hat-regular-24.png";
import statIcon from "@/assets/images/stats.png";
</script>

<template>
  <nav class="sidebar__container">
    <div>
      <figure>
        <img
          :src="Banner"
          alt="" />
      </figure>

      <side-bar-menu-link
        :icon="caseIcon"
        text="Clients" />
      <side-bar-menu-link
        :icon="hatIcon"
        text="Captains" />
      <side-bar-menu-drop-down
        inner-text="My teams"
        icon-path="groupIcon"
        :is-selected="true" />
      <side-bar-menu-link
        :icon="statIcon"
        text="Statistics" />
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
