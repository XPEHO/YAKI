<script setup lang="ts">
import {PropType, onBeforeMount, reactive} from "vue";
import type {UserWithIdType} from "@/models/userWithId.type";

import avatarIcon from "@/assets/images/avatar.png";
import defaultButton from "@/features/shared/components/DefaultButton.vue";

import {checkInvitationStatus, updateReactive} from "@/features/invitation/services/userService";

//const teammateStore = useTeammateStore();

onBeforeMount(() => {
  if (props.fromRoute.includes("captain")) {
    updateReactive(settings, checkInvitationStatus(props.user));
  }
});

const props = defineProps({
  user: {
    type: Object as PropType<UserWithIdType>,
    required: true,
  },
  fromRoute: {
    type: String,
    required: true,
  },
});

const emit = defineEmits(["invitUserToTeam", "invitUserAsCaptain"]);

const emitterRedirect = () => {
  if (props.fromRoute.includes("captain")) {
    emit("invitUserToTeam", props.user.id);
  } else {
    emit("invitUserAsCaptain", props.user.id);
  }
};

//Setting reactive with card and button configuration
// text and style
const settings = reactive({
  isInvited: false,
  text: "Invite",
  btnCSS: "button-class-test btn-bg-color-invite",
  cardCSS: "",
});

const invitBtnClick = async () => {
  if (!settings.isInvited) {
    emitterRedirect();

    cssEffect();

    settings.isInvited = true;
  }
};

const cssEffect = () => {
  // meant to be removed when mailing system is made, demo purpose
  let time = Math.floor(Math.random() * (3000 - 1000)) + 1000;

  settings.text = "Pending...";
  settings.btnCSS = "button-class-test btn-bg-color-pending";
  settings.cardCSS = "user-pending";

  // meant to be removed when mailing system is made, demo purpose
  setTimeout(() => {
    settings.text = "Accepted";
    settings.btnCSS = "button-class-test btn-bg-color-present";
    settings.cardCSS = "user-invited";
  }, time);
};
</script>

<template>
  <section
    class="user-component__card"
    :class="settings.cardCSS">
    <div>
      <article class="card__img-identity">
        <figure>
          <img
            v-bind:src="avatarIcon"
            alt="Image de profil" />
        </figure>
        <article>
          <p>{{ user.firstname }} {{ user.lastname }}</p>
        </article>
      </article>

      <default-button
        :text="settings.text"
        :css-class="settings.btnCSS"
        @click.prevent="invitBtnClick" />
    </div>
  </section>
</template>

<style scoped lang="scss">
.user-component__card {
  display: flex;
  justify-content: space-around;
  align-items: center;

  width: min(90%, 40rem);

  background-color: #e7e5e5;
  border: 2px solid transparent;
  border-radius: 16px;

  div {
    display: flex;
    align-items: center;
    width: 90%;

    padding-block: 0.3rem;

    .card__img-identity {
      display: flex;
      gap: 2rem;
      flex-grow: 3;

      figure {
        width: 3rem;
        img {
          user-select: none;
          width: 100%;
          object-fit: cover;
        }
      }
      article {
        p:nth-child(1) {
          font-size: $font-size-user-component-name;
          font-family: Inter;
          font-weight: 900;
        }
      }
    }

    .button-class-test {
      flex-basis: 8rem;

      border: none;
      border-radius: 16px;

      padding-block: 0.6rem;

      color: #000;
      font-size: $font-size-user-component-button;
      font-family: Inter;
      font-weight: 900;

      &:active {
        transform: scale(0.97);
      }
    }
  }
}

.btn-bg-color-invite {
  background-color: #bad26e;
}

.btn-bg-color-pending {
  background-color: #e6e95d;
}

.btn-bg-color-present {
  background-color: #59a9b5;
}

.user-pending {
  border-color: #e6e95d;
}

.user-invited {
  border-color: #59a9b5;
}
</style>
@/features/invitation/services/userService
