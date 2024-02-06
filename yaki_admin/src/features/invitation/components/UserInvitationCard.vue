<script setup lang="ts">
import { PropType, onMounted, ref } from "vue";
import { UserWithIdType } from "@/models/userWithId.type";
import addIcon from "@/assets/icons_svg/AddPlus.svg";
import addedUser from "@/assets/icons_svg/Validated.svg";
import InitialAvatar from "@/ui/components/InitialAvatar.vue";

const toAddSettings = {
  isInvited: false,
  cardBgColor: "user-card__accepted_status",
  btnIcon: addIcon,
};

const invitedSettings = {
  isInvited: true,
  cardBgColor: "card__invited_background_color",
  btnIcon: addedUser,
};

const props = defineProps({
  user: {
    type: Object as PropType<UserWithIdType>,
    required: true,
  },
  invitedUserList: {
    type: Object as PropType<number[]>,
    required: true,
  },
});

const visualSettings = ref(toAddSettings);

onMounted(() => {
  if (props.invitedUserList.includes(props.user.id)) {
    visualSettings.value = invitedSettings;
  }
});

/**
 * Emit to the parent component (userInvitationList)
 * From userInvitationList emitted to his parent component (userInvitationPageContent)
 * userInvitationCard => userInvitationList => userInvitationPageContent
 */
const emit = defineEmits(["emittedUserInvitation"]);

const onInvitationClick = () => {
  // check if user is already invited
  if (visualSettings.value.isInvited) {
    return;
  }
  emit("emittedUserInvitation", props.user);
  visualSettings.value = invitedSettings;
};

const btnClassList = [
  "button--general",
  "button--height-secondary",
  "button--color-secondary",
  "button--icon-text-style",
  "unselectabla-text",
];
</script>

<template>
  <article
    :class="[
      'user-card__container',
      visualSettings.cardBgColor,
      'user-card__container_surcharge_display_btn',
    ]"
  >
    <figure class="user-card__avatar rounded">
      <InitialAvatar
        :firstname="props.user.firstname"
        :lastname="props.user.lastname"
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
        <button
          @click.prevent="onInvitationClick"
          :class="[btnClassList, 'custom-bnt-width']"
        >
          <figure>
            <img
              :src="visualSettings.btnIcon"
              alt="arrow-left"
            />
          </figure>
        </button>
      </div>
    </section>
  </article>
</template>

<style scoped lang="scss">
.custom-bnt-width {
  width: 5rem;
}

.user-card__container_surcharge_display_btn {
  & .user-card__wrapper-status_buttons {
    display: flex;
    gap: 1rem;
  }
}
$background-color-user-card-invited: #e6edee;
$background-color-user-card-invited-hover: #ecf0f5;

.card__invited_background_color {
  background-color: $background-color-user-card-invited;
  &:hover {
    background-color: $background-color-user-card-invited-hover;
  }
  & .user-card__wrapper-status_label {
    display: none;
  }
}
</style>
