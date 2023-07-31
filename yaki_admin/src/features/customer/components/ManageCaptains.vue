<script setup="ts">
import router from "../../../../src/router/router";
import modalValidationState from "@/features/shared/services/modalValidationState";
import ModalValidation from "@/features/shared/components/ModalValidation.vue";
import { onBeforeMount } from "vue";
import { useCaptainStore } from "../../../../src/stores/captainStore.js";
const captainStore = useCaptainStore();
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
      v-bind:inner-text="'Add captains'"
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
</template>
<style lang="scss">
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300&display=swap");
.customer-view-captains {
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
.captain-list {
  padding: 50px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 3rem;
}
</style>
