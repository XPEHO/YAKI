<script setup lang="ts">
import UserInfoCard from "@/ui/components/UserInfoCard.vue";
import { UserWithIdType } from "@/models/userWithId.type";
import { PropType } from "vue";
import { useTeamStore } from "@/stores/teamStore";

//Get the stores
const teamStore = useTeamStore();

defineProps({
  userList: {
    type: Object as PropType<UserWithIdType[]>,
    required: true,
  },
  /**
   * Parameter to set if the component will be using the team description
   * By default is false, as only Team page will use it.
   */
  isUsingTeamDescription: {
    type: Boolean,
    default: false,
  },
});
</script>

<template>
  <section class="user-list__container">
    <p
      v-if="isUsingTeamDescription && teamStore.getTeamSelected.teamDescription"
      class="text_default__Team_description"
    >
      {{ teamStore.getTeamSelected.teamDescription }}
    </p>
    <p
      v-if="isUsingTeamDescription && userList && userList.length > 0"
      class="text_default__Team_name"
    >
      {{ $t("general.teammates") }} :
    </p>
    <section class="user-list__in-team-container">
      <user-info-card
        v-for="user in userList"
        :user="user"
        :key="user.id"
      />
    </section>
  </section>
</template>

<style scoped lang="scss">
$border-radius: 24px;
.user-list__container {
  padding-block-end: 10rem;

  > p:nth-of-type(1) {
    padding-block-end: 32px;
  }

  > p:nth-of-type(2) {
    padding-block-end: 16px;
  }

  .user-list__in-team-container {
    border-radius: $border-radius;
    article:nth-of-type(1) {
      border-top-left-radius: $border-radius;
      border-top-right-radius: $border-radius;
    }

    article:last-of-type {
      border-bottom-left-radius: $border-radius;
      border-bottom-right-radius: $border-radius;
    }
  }
}
</style>
