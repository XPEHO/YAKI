<script setup lang="ts">
import buttonTextIcon from "@/components/ButtonTextIcon.vue";
import buttonIcon from "@/components/ButtonIcon.vue";

import {TeamType} from "@/models/team.type";
import {PropType} from "vue";
import router from "@/router/router";

import teamImage from "@/assets/images/splashscreen.svg";
import addIcon from "@/assets/images/plus_icon.png";
import dotIcon from "@/assets/images/dots-vertical-rounded-regular-24.png";
import modalState from "@/features/shared/modal/services/modalState";
import {MODALMODE} from "@/features/shared/modal/services/modalMode";

const onClickDeleteTeam = () => {
  modalState.setTeamName(modalState.teamName);
  modalState.switchModalVisibility(true, MODALMODE.teamDelete);
};
</script>

<template>
  <section class="header-team__container">
    <div>
      <div>
        <figure>
          <img
            :src="teamImage"
            alt="" />
        </figure>
        <h1>{{ modalState.teamName }}</h1>
      </div>

      <div>
        <button-text-icon
          @click.prevent="router.push({path: `invitation`})"
          :icon="addIcon"
          text="INVIT" />

        <button-icon
          :icon="dotIcon"
          @click.prevent="onClickDeleteTeam" />
      </div>
    </div>

    <p>team description : coming soon</p>
  </section>
</template>

<style scoped lang="scss">
.header-team__container {
  display: flex;
  flex-direction: column;
  gap: 16px;

  padding-inline: 40px;
  padding-block: 24px 16px;

  figure {
    background-color: black;
    width: 48px;
    height: 48px;
    border-radius: 16px;
    img {
      width: 100%;
      object-fit: contain;
    }
  }

  > div {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    > div:nth-of-type(1) {
      display: flex;
      align-items: center;
      gap: 8px;
    }
    > div:nth-last-of-type(1) {
      display: flex;
      align-items: center;
      gap: 16px;
    }
  }

  h1 {
    font-size: 40px;
    font-style: normal;
    font-weight: 500;
    line-height: 100%; /* 40px */
    letter-spacing: -2px;
  }

  p {
    color: #7d818c;
    font-family: Rubik;
    font-size: 15px;
    font-style: normal;
    font-weight: 400;
    line-height: 150%;
  }
}
</style>
