<script setup lang="ts">
import {PropType} from "vue";
import type {TeammateType} from "@/models/teammate.type";

import avatarIcon from "@/assets/images/avatar.png";
import editIcon from "@/assets/images/Edit.png";
import deleteIcon from "@/assets/images/Delete.png";
import {UserWithIdType} from "@/models/userWithId.type";

import modalState from "@/features/shared/services/modalState";
import {useTeamStore} from "@/stores/teamStore.js";
const teamStore = useTeamStore();

const props = defineProps({
  user: {
    type: Object as PropType<TeammateType | UserWithIdType>,
    required: true,
  },
});

const UserToBeRemoved = () => {
  modalState.setTeammateIDAndInformations(props.user.id, `${props.user.firstname} ${props.user.lastname}`);
};
</script>

<template>
  <section class="user">
    <div class="user-avatar-info">
      <img
        class="avatar"
        v-bind:src="avatarIcon"
        alt="Avatar" />
      <div class="user-info">
        <h1 class="name">{{ user.firstname }} {{ user.lastname }}</h1>
        <h2 class="email">{{ user.email }}</h2>
      </div>
    </div>
    <div class="delete-edit-icon">
      <button>
        <figure>
          <img
            class="user-icon"
            v-bind:src="editIcon"
            alt="" />
        </figure>
      </button>
      <button @click.prevent="UserToBeRemoved">
        <figure>
          <img
            class="user-icon"
            v-bind:src="deleteIcon"
            alt="" />
        </figure>
      </button>
    </div>
  </section>
</template>

<style scoped lang="scss">
.user {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  justify-content: space-between;

  width: 60%;
}

.user-avatar-info {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  gap: 2rem;
}

.user-info {
  display: flex;
  flex-direction: column;
}
.name {
  font-size: $font-size-user-info-name;
}
.email {
  font-size: $font-size-user-info-email;
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
      .user-icon {
        width: 100%;
        object-fit: contain;
      }
    }
  }
}
</style>
