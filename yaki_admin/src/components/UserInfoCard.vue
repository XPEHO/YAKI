<script setup lang="ts">
import buttonIcon from "@/components/ButtonIcon.vue";
import pencilIcon from "@/assets/images/pencil-regular-24.png";
import deleteIcon from "@/assets/images/x_close.png";
import userAvatar from "@/assets/images/avatar_2.png";

import {PropType} from "vue";
import {UserWithIdType} from "@/models/userWithId.type";
import {MODALMODE} from "@/constants/modalMode";
import {useModalStore} from "@/stores/modalStore";
import {useTeammateStore} from "@/stores/teammateStore";

const modalStore = useModalStore();
const teammateStore = useTeammateStore();

const props = defineProps({
  user: {
    type: Object as PropType<UserWithIdType>,
    required: true,
  },
});

const UserToBeRemoved = () => {
  teammateStore.setIdOfTeammateToDelete(props.user.teammateId);
  modalStore.setTeammateNameToDelete(`${props.user.firstname} ${props.user.lastname}`);
  modalStore.switchModalVisibility(true, MODALMODE.userDelete);
};
</script>

<template>
  <article class="user-card__container user-card__accepted_status">
    <figure class="user-card__avatar">
      <img
        :src="userAvatar"
        alt="user-card" />
    </figure>
    <div class="user-card__wrapper-user-infos">
      <p class="user-card__name-text">{{ user.firstname }} {{ user.lastname }}</p>
      <p>{{ user.email }}</p>
    </div>
    <section class="user-card__wrapper-status">
      <div class="user-card__wrapper-status_label">
        <p class="label label--text label-primary-color">en attente</p>
      </div>
      <div class="user-card__wrapper-status_buttons">
        <button-icon
          :icon="pencilIcon"
          alt="accepter" />
        <button-icon
          @click.prevent="UserToBeRemoved"
          :icon="deleteIcon"
          alt="refuser" />
      </div>
    </section>
    <section></section>
  </article>
</template>
