<script setup lang="ts">
import SideBarButton from "@/features/shared/components/SideBarButton.vue";
import modalValidationState from "@/features/shared/services/modalValidationState";
import ModalValidation from "@/features/shared/components/ModalValidation.vue";

import { useCaptainStore } from "../../../../src/stores/captainStore.js";
import { useTeamStore } from "../../../../src/stores/teamStore.js";

import plusIcon from "../../../../src/assets/plus.png";
import router from "../../../../src/router/router";
import { onBeforeMount } from "vue";

const captainStore = useCaptainStore();
const teamStore = useTeamStore();

const fetchCaptains = async () => {
  await captainStore.getAllCaptainsByCustomerId(captainStore.getCustomerId);
};

onBeforeMount(async () => {
  fetchCaptains();
});

const removeCaptainFromCustomer = (id: number, informations: string) => {
  captainStore.setCaptainToDelete(id);
  modalValidationState.setInformation(informations);
  modalValidationState.changeVisibility();
};

const removeTeamFromCustomer = (id: number, informations: string) => {
  teamStore.setTeamToDelete(id);
  modalValidationState.setInformation(informations);
  modalValidationState.changeVisibility();
};

const validationModalAccept = () => {
  captainStore.deleteCaptain(captainStore.getCaptainToDelete);
  setTimeout(() => {
    fetchCaptains();
  }, 150);
};
</script>

<template>
  <modal-validation
    v-show="modalValidationState.isShowed"
    @modal-accept="validationModalAccept" />
  <div class="customer-view-captains">
    <h1 class="title">Customer</h1>
    <h2 class="text">Manage your captains here</h2>
    <hr class="line" />

    <side-bar-button
      v-bind:inner-text="'Add Customer'"
      v-bind:icon-path="plusIcon"
      @click.prevent="router.push({ path: `invitation` })" />

    <div class="captain-list">
      <captain
        :captain="captain"
        v-for="captain in captainStore.getCaptainList"
        :key="captain.id"
        @RemoteCaptain="removeCaptainFromCustomer" />
    </div>
  </div>
  <div class="customer-view-teams">
    <h1 class="title">Customer</h1>
    <h2 class="text">Manage your teams</h2>
    <hr class="line" />

    <side-bar-button
      v-bind:inner-text="'Add Team'"
      v-bind:icon-path="plusIcon"
      @click.prevent="router.push({ path: `invitation` })" />

    <div class="team-list">
      <team
        :team="team"
        v-for="team in teamStore.getTeamList"
        :key="team.id"
        @RemoteTeam="removeTeamFromCustomer" />
    </div>
  </div>
</template>

<style lang="scss">
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300&display=swap");

.customer-view-captains,
.customer-view-teams {
  padding: 30px;
  font-family: "Inter", sans-serif;
}
.title {
  font-size: 38px;
}
.text {
  font-size: 18px;
  color: #787878;
  margin-bottom: 20px;
}
.line {
  width: 80%;
  background-color: #efefefed;
  margin-bottom: 1rem;
}
.captain-list,
.team-list {
  padding: 50px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3rem;
}
</style>
