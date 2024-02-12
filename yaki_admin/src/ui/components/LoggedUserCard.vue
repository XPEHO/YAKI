<script setup lang="ts">
import avatarIcon from "@/assets/images/avatarLetters.png";
import { UserWithIdType } from "@/models/userWithId.type";
import router from "@/router/router";
import { onMounted } from "vue";

const profile = () => {
  router.push("/dashboard/profile");
};

let user: UserWithIdType | null = null;

const token = localStorage.getItem("token");

console.log("token", token);

const fetchUser = async () => {
  try {
    const response = await fetch(import.meta.env.BASE_URL + "/users/current-user", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });

    console.log("response", response);

    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    user = await response.json();

    console.log("user", user);
  } catch (e) {
    console.error("Error fetching user:", e);
  }
};

onMounted(fetchUser);
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
      <p class="user-card__name-text">{{ user?.lastname }}</p>
      <p class="user-card__email_text">{{ user?.firstname }}</p>
    </div>
  </article>
</template>

<style scoped lang="scss">
.selection-cursor {
  cursor: pointer;
}
</style>
