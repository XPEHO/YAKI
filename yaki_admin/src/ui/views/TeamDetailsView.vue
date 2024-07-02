<script setup lang="ts">
import TeamDetailsCard from "@yaki_ui/yaki_ui_web_components/components/vue/TeamDetailsCard.vue";
import UserInfoCard from "@/ui/components/UserInfoCard.vue";
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import addIcon from "@/assets/icons_svg/AddPlus.svg";
import buttonTextIcon from "@/ui/components/buttons/ButtonTextIcon.vue";

import { useStatisticsStore } from "@/stores/statisticsStore";
import { useTeamStore } from "@/stores/teamStore";
import { useTeammateStore } from "@/stores/teammateStore";
import { UserWithIdType } from "@/models/userWithId.type";
import { useCaptainStore } from "@/stores/captainStore";
import { useModalStore } from "@/stores/modalStore";
import { TeamType } from "@/models/team.type";
import { MODALMODE } from "@/constants/modalMode.enum";
import { useRoute } from "vue-router";
import { onBeforeMount, ref } from "vue";

const modalStore = useModalStore();

const teamStore = useTeamStore();
const teamMateStore = useTeammateStore();
const statisticsStore = useStatisticsStore();
const captainStore = useCaptainStore();

const route = useRoute();
const teamDetailsParams = Number(route.params.id);

const teamDetails = ref<TeamType>({
  id: 0,
  teamName: "",
  customerId: 0,
  captainsId: [],
  captains: [],
  teamDescription: null,
});
const captains = ref<UserWithIdType[]>();
const teamMates = ref<UserWithIdType[]>();

onBeforeMount(async () => {
  await Promise.all([
    teamStore.setCurrentTeamData(teamDetailsParams),
    captainStore.setAllCaptainsByCustomerId(captainStore.getCurrentCustomerId),
    teamMateStore.setTeammatesByTeamId(teamDetailsParams),
    statisticsStore.setTeamsLatestActivityByCustomerId(undefined, teamDetailsParams),
  ]),
    (teamDetails.value = {
      ...teamStore.getTeamSelected,
      lastActivity: statisticsStore.getTeamsLatestActivity[0].lastActivityDate,
    });
  captains.value = captainStore.getCaptainList;
  teamMates.value = teamMateStore.getTeammateList;
});
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header
        :title="teamDetails.teamName"
        :isTeamManagement="true"
      />
    </template>
    <template #content>
      <section class="teamDetails">
        <p>{{ teamDetails.teamDescription }}</p>

        <h4>{{ $t("general.details") }}</h4>
        <div v-if="teamDetails">
          <team-details-card :team="teamDetails" />
        </div>

        <span class="captain-list-header">
          <h4>{{ $t("general.captains") }}</h4>
          <button-text-icon
            @click.prevent="
              () => {
                modalStore.setMode(MODALMODE.comingSoon), modalStore.setIsShow(true);
              }
            "
            :icon="addIcon"
            :text="$t('buttons.add')"
          />
        </span>
        <div v-if="teamMates">
          <user-info-card
            v-for="(captain, index) in captains"
            :key="index"
            :user="captain"
          />
        </div>

        <h4>{{ $t("general.teammates") }}</h4>
        <div v-if="teamMates">
          <user-info-card
            v-for="(teammate, index) in teamMates"
            :key="index"
            :user="teammate"
          />
        </div>
      </section>
    </template>
  </page-content-layout>
</template>

<style scoped lang="scss">
h4 {
  font-family: "Rubik";
  font-weight: 400;
  color: $color-font-sub-text;
  padding: 1rem;
}

p {
  font-family: "Rubik";
}

.captain-list-header {
  display: grid;
  grid-template-columns: 80% 20%;
  margin: 2rem 0 0.3rem 0;
}
</style>
