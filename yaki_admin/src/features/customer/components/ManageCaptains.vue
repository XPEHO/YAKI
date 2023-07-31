<script setup="ts">
import modalValidationState from "@/features/shared/services/modalValidationState";
import ModalValidation from "@/features/shared/components/ModalValidation.vue";

import { onBeforeMount } from "vue";
import { useCaptainStore } from "../../../../src/stores/captainStore.ts";

const captainStore = useCaptainStore();

const fetchCaptains = async () => {
  await captainStore.getAllCaptainsByCustomerId(captainStore.getCustomerId);
};

onBeforeMount(async () => {
  fetchCaptains();
});

const removeCaptainFromCustomer = (id, informations) => {
  captainStore.setCaptainToDelete(id);
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
    <h1 class="title">Captains List</h1>
    <h2 class="text">Manage your captains here</h2>
    <hr class="line" />

    <div class="captain-list">
      <captain
        :captain="captain"
        v-for="captain in captainStore.getCaptainList"
        :key="captain.id"
        @RemoteCaptain="removeCaptainFromCustomer" />
    </div>
  </div>
</template>

<style lang="scss">
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300&display=swap");

</style>
