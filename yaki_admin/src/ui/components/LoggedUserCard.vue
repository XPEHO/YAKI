<script setup lang="ts">
import avatarIcon from "@/assets/images/avatarLetters.png";
import router from "@/router/router";

const profile = () => {
  router.push("/dashboard/profile");
};
</script>

<template>
  <article
    @click="profile"
    class="user-card__container logged_user_card selection-cursor"
  >
    <figure class="user-card__avatar">
      <img
        :src="avatarIcon"
        alt="user-card"
      />
    </figure>
    <div class="user-card__wrapper-user-infos">
      <p class="user-card__name-text">Admin</p>
      <p class="user-card__email_text">Administrator</p>
    </div>
  </article>
</template>

<style scoped lang="scss">
.selection-cursor {
  cursor: pointer;
}
</style>
