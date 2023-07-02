<script setup lang="ts">
import UserComponent from "@/features/invitation/components/UserComponent.vue";

import YakiButton from "@/features/shared/components/YakiButton.vue";
import router from "@/router/router";

const numberTest = [1, 2, 3, 4, 5, 6, 7, 8, 9];

const acceptClick = () => {
  router.go(-1);
};

const goToCaptain = () => {
  router.go(-1);
};
</script>

<template>
  <section class="main_wrapper">
    <div class="invitation__container">
      <article class="header">
        <h1 class="title">Invite Teammate</h1>
        <h2 class="text">Select teammates to add to the team</h2>
        <hr class="line" />
      </article>
      <div class="buttons_container">
        <yaki-button
          text="Accept"
          css-class="button_style button_accept"
          @click="acceptClick" />
        <yaki-button
          text="Cancel"
          css-class="button_style button_cancel"
          @click="goToCaptain" />
      </div>
      <div class="user_list_container">
        <user-component
          v-for="number in numberTest"
          class="user_unit" />
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

    gap: 1rem;
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

.buttons_container {
  width: 80%;

  display: flex;
  justify-content: space-between;
}

.user_list_container {
  width: 65%;
  padding-block-start: 2rem;

  display: flex;
  flex-direction: column;
  gap: 1.2rem;
}

.button_style {
  display: flex;
  align-items: center;
  justify-content: center;

  border: none;
  border-radius: 5rem;
  background-color: #bad26e;
  height: 90%;

  padding-block: 1rem;

  color: #000;
  font-size: 1rem;
  font-family: Inter;
  font-weight: 900;

  width: min(8rem, 15rem);

  &:active {
    transform: scale(0.97);
  }
}

.button_accept {
  background-color: #b3d26bba;
}

.button_cancel {
  background-color: #f86d63;
}
</style>
