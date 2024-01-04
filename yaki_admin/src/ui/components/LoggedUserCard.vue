<script setup lang="ts">
import avatarIcon from "@/assets/images/avatar_2.png";
import router from "@/router/router";

const profile = () => {
  router.push("/dashboard/profile");
};
</script>

<template>
  <article class="user-card__container logged_user_card">
    <figure class="user-card__avatar">
      <img
        :src="avatarIcon"
        alt="user-card"
      />
    </figure>
    <div
      class="user-card__wrapper-user-infos"
      @click="profile"
    >
      <p class="user-card__name-text">Admin</p>
      <p>Administrator</p>
    </div>
  </article>
</template>

<style scoped lang="scss">
.user-card__wrapper-user-infos {
  cursor: pointer;
}
</style>
