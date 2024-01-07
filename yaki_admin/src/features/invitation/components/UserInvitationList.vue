<script setup lang="ts">
import UsersInvitationCard from "@/features/invitation/components/UserInvitationCard.vue";
import { UserWithIdType } from "@/models/userWithId.type";
import { PropType, onMounted, ref } from "vue";

const props = defineProps({
  userList: {
    type: Object as PropType<UserWithIdType[]>,
    required: true,
  },
  invitedUsers: {
    type: Array as PropType<number[]>,
    required: true,
  },
});

const filteredUserList = ref<UserWithIdType[]>([]);

onMounted(() => {
  if (props.userList && props.invitedUsers) {
    if (props.invitedUsers.length === 0) {
      filteredUserList.value = props.userList;
      return;
    }
    filteredUserList.value = props.userList.filter((user) => {
      return !props.invitedUsers.includes(user.id);
    });
  }
});

/**
 * Emit to the parent component (userInvitationPageContent)
 */
const emit = defineEmits(["emittedUserInvitation"]);

const onUserInvitation = (invitedUser: UserWithIdType) => {
  emit("emittedUserInvitation", invitedUser);
};
</script>

<template>
  <section class="user-list__container">
    <section class="user-list__in-team-container">
      <users-invitation-card
        v-for="user in filteredUserList"
        :user="user"
        :key="user.id"
        @emittedUserInvitation="onUserInvitation"
      />
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
