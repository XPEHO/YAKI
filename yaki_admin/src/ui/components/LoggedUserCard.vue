<script setup lang="ts">
import avatarIcon from "@/assets/images/avatarLetters.png";
import { UserWithIdType } from "@/models/userWithId.type";
import router from "@/router/router";
import { usersService } from "@/services/users.service";
import { onMounted } from "vue";

const profile = () => {
  router.push("/dashboard/profile");
};

let user: UserWithIdType | null = null;

const fetchUser = async () => {
  let storedUser = localStorage.getItem("user");
  let token = null;

  if (storedUser) {
    let parsedUser = JSON.parse(storedUser);
    token = parsedUser.token;
  }

  console.log("Token:", token);

  try {
    user = await usersService.getCurrentUser(token);

    console.log("User:", user); // Log the user
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
      <p class="user-card__name-text"></p>
      <p class="user-card__name_text"></p>
    </div>
  </article>
</template>

<style scoped lang="scss">
.selection-cursor {
  cursor: pointer;
}
</style>
