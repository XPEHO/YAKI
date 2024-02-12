<script setup lang="ts">
import InitialAvatar from "@/ui/components/InitialAvatar.vue";
import { UserWithIdType } from "@/models/userWithId.type";
import router from "@/router/router";
import { usersService } from "@/services/users.service";
import { ref, onMounted } from "vue";

const profile = () => {
  router.push("/dashboard/profile");
};

let user = ref<UserWithIdType | null>(null);

const fetchUser = async () => {
  let storedUser = localStorage.getItem("user");
  let token = null;

  if (storedUser) {
    let parsedUser = JSON.parse(storedUser);
    token = parsedUser.token;
  }

  console.log("Token:", token);

  try {
    const fetchedUser = await usersService.getCurrentUser(token);
    user.value = fetchedUser;

    console.log("User:", user.value); // Log the user
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
      <InitialAvatar
        :firstname="user?.firstname"
        :lastname="user?.lastname"
      />
    </figure>
    <div class="user-card__wrapper-user-infos">
      <p class="user-card__name-text">{{ user?.firstname }}</p>
      <p class="user-card__name_text">{{ user?.lastname }}</p>
    </div>
  </article>
</template>

<style scoped lang="scss">
.selection-cursor {
  cursor: pointer;
}
</style>
