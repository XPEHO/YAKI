<script setup lang="ts">
import buttonIcon from "@/ui/components/buttons/ButtonIcon.vue";
import pencilIcon from "@/assets/icons_svg/Edit.svg";
import deleteIcon from "@/assets/icons_svg/CrossClose.svg";
import InitialAvatar from "@/ui/components/InitialAvatar.vue";
import { PropType } from "vue";
import { UserWithIdType } from "@/models/userWithId.type";
import { MODALMODE } from "@/constants/modalMode.enum";
import { useModalStore } from "@/stores/modalStore";
import { useTeammateStore } from "@/stores/teammateStore";
import { useCaptainStore } from "@/stores/captainStore";
import { useRoute } from "vue-router";
import { setUserAvatarUrl } from "../../utils/images.utils";

//Get the stores
const modalStore = useModalStore();
const teammateStore = useTeammateStore();
const captainStore = useCaptainStore();

//Get the route
const route = useRoute();

//define the props
const props = defineProps({
  user: {
    type: Object as PropType<UserWithIdType>,
    required: true,
  },
});

//define the methods
const onRemoveUserPress = () => {
  switch (route.fullPath) {
    case "/dashboard/manage-team":
      teammateStore.setIdOfTeammateToDelete(props.user.teammateId);
      modalStore.setTeammateNameToDelete(`${props.user.firstname} ${props.user.lastname}`);
      modalStore.switchModalVisibility(true, MODALMODE.userDelete);
      break;
    case "/dashboard/manage-captains":
      captainStore.setCaptainToDelete(props.user.captainId);
      modalStore.setCaptainNameToDelete(`${props.user.firstname} ${props.user.lastname}`);
      modalStore.switchModalVisibility(true, MODALMODE.captainDelete);
      break;
  }
};

const OpenModalNotImplemented = () => {
  modalStore.switchModalVisibility(true, MODALMODE.comingSoon);
};
</script>

<template>
  <article class="user-card__container user-card__accepted_status">
    <figure class="user-card__avatar rounded">
      <div v-if="setUserAvatarUrl(props.user) !== ''">
        <img
          class="user-card__avatar-img"
          :src="setUserAvatarUrl(props.user)"
          alt="user-card"
        />
      </div>
      <div v-else>
        <InitialAvatar
          :firstname="props.user.firstname"
          :lastname="props.user.lastname"
        />
      </div>
    </figure>

    <div class="user-card__wrapper-user-infos">
      <p class="user-card__name-text">{{ user.firstname }} {{ user.lastname }}</p>
      <p class="user-card__email_text">{{ user.email }}</p>
    </div>
    <section class="user-card__wrapper-status">
      <div class="user-card__wrapper-status_label">
        <p class="label label--text label-primary-color">en attente</p>
      </div>
      <div class="user-card__wrapper-status_buttons">
        <button-icon
          @click.prevent="OpenModalNotImplemented"
          :icon="pencilIcon"
          alt="modifier"
        />

        <button-icon
          @click.prevent="onRemoveUserPress"
          :icon="deleteIcon"
          alt="supprimer"
        />
      </div>
    </section>
  </article>
</template>
