<script setup lang="ts">
import { useSelectedRoleStore } from "@/stores/selectedRole";
import { useTeamStore } from "@/stores/teamStore";
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import { computed, onBeforeMount, onMounted, ref } from "vue";
import InviteMemberTutorial from "@/ui/components/tutoriels/InviteMemberTutorial.vue";
import TeamList from "@/ui/components/TeamList.vue";
import chevronLeftIcon from "@/assets/icons_svg/Chevron-left.svg";
import chevronRightIcon from "@/assets/icons_svg/Chevron-right.svg";

const selectedRoleStore = useSelectedRoleStore();
const teamStore = useTeamStore();

onBeforeMount(() => {
  // If the user is a customer
  teamStore.setTeamsListByCustomerId(selectedRoleStore.getCustomerIdSelected);
});

const getTeamList = () => {
  return teamStore.getTeamListByCustomer;
};

// Pagination variables
const currentPage = ref(1);
const rowsPerPage = 10;

// Computed property for pagination
const paginatedTeamsArray = computed(() => {
  // We get the start using the currentPage and rowsPerPage=
  let start = (currentPage.value - 1) * rowsPerPage;
  // We get the end using the start and rowsPerPage
  let end = start + rowsPerPage;
  return getTeamList().slice(start, end);
});

// Methods for pagination
const nextPage = () => {
  if (currentPage.value * rowsPerPage < getTeamList().length) {
    currentPage.value++;
  }
};

const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--;
  }
};
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header :title="$t('sidebar.teams')" />
    </template>
    <template #content>
      <team-list
        v-if="paginatedTeamsArray.length > 0"
        :teamList="paginatedTeamsArray"
      />

      <invite-member-tutorial v-else />
    </template>
  </page-content-layout>
  <section
    v-if="getTeamList().length > rowsPerPage"
    class="page_handling__container"
  >
    <button
      class="page_count_button"
      @click.prevent="prevPage"
      :style="currentPage === 1 ? 'pointer-events: none; opacity: 0.2;' : ''"
    >
      <figure>
        <img
          :src="chevronLeftIcon"
          alt=""
        />
      </figure>
    </button>

    <div>
      <p>Page : {{ currentPage }} / {{ Math.ceil(getTeamList().length / rowsPerPage) }}</p>
    </div>

    <button
      class="page_count_button"
      @click.prevent="nextPage"
      :style="
        currentPage * rowsPerPage >= getTeamList().length
          ? 'pointer-events: none; opacity: 0.2;'
          : ''
      "
    >
      <figure>
        <img
          :src="chevronRightIcon"
          alt=""
        />
      </figure>
    </button>
  </section>
</template>

<style scoped lang="scss">
.page_handling__container {
  position: absolute;
  bottom: 0;

  width: 95%;
  height: 80px;
  margin-inline: 1rem;

  display: flex;
  justify-content: center;
  align-items: center;
  gap: 3rem;

  $size: 40px;

  background-color: $background-color-theme-primary;

  figure {
    width: $size;
    height: $size;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }

  p {
    font-family: $font-sf-pro;
  }

  .page_count_button {
    border: none;
    background-color: $background-color-theme-primary;
    cursor: pointer;

    &:hover {
      cursor: pointer;
    }

    &:active {
      transform: scale(0.9);
    }
  }
}
</style>
