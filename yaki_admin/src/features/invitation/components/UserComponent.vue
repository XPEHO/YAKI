<script setup lang="ts">
import {PropType, onBeforeMount, reactive} from "vue";
import type {UserWithIdType} from "@/models/userWithId.type";

import {useTeamStore} from "@/stores/teamStore.js";

import avatarIcon from "@/assets/images/avatar.png";
import YakiButton from "@/features/shared/components/DefaultButton.vue";

const teamStore = useTeamStore();

// props coming from LayoutInvitation, setting user from "v-for"
const props = defineProps({
  user: {
    type: Object as PropType<UserWithIdType>,
    required: true,
  },
});

//Setting reactive with card and button configuration
// text and style
const settings = reactive({
  isInvited: false,
  text: "Invite",
  btnCSS: "button-class-test btn-bg-color-invite",
  cardCSS: "",
});

// get teammate list before mount to check if current user already is in it before change settings

onBeforeMount(() => {
  for (const teammate of teamStore.getTeammateList) {
    if (teammate.userId === props.user.id) {
      settings.isInvited = true;
      settings.text = "In Team";
      settings.btnCSS = "button-class-test btn-bg-color-present";
      settings.cardCSS = "user-invited";
    }
  }
});

// emitter to send on invit btn click the userID (to create the teammate)
const emit = defineEmits(["GetUserId"]);

const invitBtnClick = () => {
  if (!settings.isInvited) {
    emit("GetUserId", props.user.id);

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

    settings.isInvited = true;
  }
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

      <yaki-button
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

  width: 55%;

  background-color: #d9d9d9;
  border: 3px solid transparent;

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
          font-size: 1.1rem;
          font-family: Inter;
          font-weight: 900;
        }
      }
    }

    .button-class-test {
      flex-basis: 8rem;

      border: none;
      border-radius: 5rem;

      padding-block: 0.6rem;

      color: #000;
      font-size: 0.9rem;
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
