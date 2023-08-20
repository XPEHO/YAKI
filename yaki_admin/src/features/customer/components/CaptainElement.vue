<script setup lang="ts">
import {PropType} from "vue";
import {UserWithIdType} from "@/models/userWithId.type";

import avatarIcon from "@/assets/images/avatar.png";
import editIcon from "@/assets/images/Edit.png";
import deleteIcon from "@/assets/images/Delete.png";

const props = defineProps({
  captain: {
    type: Object as PropType<UserWithIdType>,
    required: true,
  },
});
</script>

<template>
  <dialog></dialog>

  <section class="team-mate">
    <div class="team-mate-avatar-info">
      <img
        class="avatar"
        v-bind:src="avatarIcon"
        alt="Avatar" />
      <div class="team-mate-info">
        <h1 class="name">{{ captain.firstname }} {{ captain.lastname }}</h1>
        <h2 class="email">{{ captain.email }}</h2>
      </div>
    </div>
    <div class="delete-edit-icon">
      <button>
        <figure>
          <img
            class="team-mate-icon"
            v-bind:src="editIcon"
            alt="" />
        </figure>
      </button>
      <button @click.prevent="() => {}">
        <figure>
          <img
            class="team-mate-icon"
            v-bind:src="deleteIcon"
            alt="" />
        </figure>
      </button>
    </div>
  </section>
</template>

<style lang="scss">
.team-mate {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  justify-content: space-between;
  width: 60%;
}

.team-mate-avatar-info {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  gap: 2rem;
}

.team-mate-info {
  display: flex;
  flex-direction: column;
}
.name {
  font-size: 18px;
}
.email {
  font-size: 15px;
  color: #787878;
}
.avatar {
  width: 44px;
  height: 44px;
}

.delete-edit-icon {
  display: flex;
  gap: 2rem;

  button {
    border: none;
    background-color: transparent;

    &:active {
      transform: scale(0.95);
    }

    figure {
      width: 1.6rem;
      .team-mate-icon {
        width: 100%;
        object-fit: contain;
      }
    }
  }
}
</style>
