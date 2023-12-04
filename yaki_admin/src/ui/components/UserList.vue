<script setup lang="ts">
import UserInfoCard from "@/ui/components/UserInfoCard.vue";
import {UserWithIdType} from "@/models/userWithId.type";
import {PropType} from "vue";
import {useTeamStore} from "@/stores/teamStore";

const teamStore = useTeamStore();

const props = defineProps({
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
    <p v-if="isUsingTeamDescription && teamStore.getTeamSelected.teamDescription">
      {{ teamStore.getTeamSelected.teamDescription }}
    </p>
    <p v-if="userList && userList.length > 0">Teammates :</p>
    <section class="user-list__in-team-container">
      <user-info-card
        v-for="user in userList"
        :user="user"
        :key="user.id" />
    </section>
  </section>
</template>

<style scoped lang="scss">
$border-radius: 24px;
.user-list__container {
  padding-block-end: 10rem;

  > p:nth-of-type(1) {
    color: #7d818c;
    font-family: Rubik;
    font-size: 15px;
    font-style: normal;
    font-weight: 400;
    line-height: 150%;

    padding-block-end: 32px;
  }

  > p:nth-of-type(2) {
    color: #7d818c;
    font-size: 16px;
    font-style: normal;
    font-weight: 400;
    line-height: 100%;

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
