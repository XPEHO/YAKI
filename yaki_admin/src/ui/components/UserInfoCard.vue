<script setup lang="ts">
import buttonIcon from "@/ui/components/buttons/ButtonIcon.vue";
import pencilIcon from "@/assets/icons_svg/Edit.svg";
import deleteIcon from "@/assets/icons_svg/CrossClose.svg";
import { PropType } from "vue";
import { UserWithIdType } from "@/models/userWithId.type";
import { MODALMODE } from "@/constants/modalMode.enum";
import { useModalStore } from "@/stores/modalStore";
import { useTeammateStore } from "@/stores/teammateStore";
import { setUserAvatarUrl } from "@/utils/images.utils";
import { useCaptainStore } from "@/stores/captainStore";

const modalStore = useModalStore();
const teammateStore = useTeammateStore();
const captainStore = useCaptainStore();

const props = defineProps({
  user: {
    type: Object as PropType<UserWithIdType>,
    required: true,
  },
});

const UserToBeRemoved = () => {
  // teammateStore.setIdOfTeammateToDelete(props.user.teammateId);
  // modalStore.setTeammateNameToDelete(
  //   `${props.user.firstname} ${props.user.lastname}`
  // );

  captainStore.setCaptainToDelete(props.user.captainId);
  console.log("userinfocard captain id props user", props.user.captainId);
  modalStore.setCaptainNameToDelete(`${props.user.firstname} ${props.user.lastname}`);
  modalStore.switchModalVisibility(true, MODALMODE.userDelete);
};

const OpenModalNotImplemented = () => {
  modalStore.switchModalVisibility(true, MODALMODE.comingSoon);
};
</script>

<template>
  <article class="user-card__container user-card__accepted_status">
    <figure class="user-card__avatar rounded">
      <img
        class="user-card__avatar-img"
        :src="setUserAvatarUrl(props.user)"
        alt="user-card"
      />
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
          @click.prevent="UserToBeRemoved"
          :icon="deleteIcon"
          alt="supprimer"
        />
      </div>
    </section>
  </article>
</template>
