<script setup lang="ts">
import buttonTextIcon from "@/components/ButtonTextIcon.vue";
import buttonIcon from "@/components/ButtonIcon.vue";

import router from "@/router/router";

import modalTeamEditDelete from "@/components/ModalTeamEditDelete.vue";
import teamImage from "@/assets/images/splashscreen.svg";
import addIcon from "@/assets/images/plus_icon.png";
import dotIcon from "@/assets/images/dots-vertical-rounded-regular-24.png";
import {onMounted, onUnmounted, ref} from "vue";
import {useTeamStore} from "@/stores/teamStore";

const teamStore = useTeamStore();

const isModalVisible = ref(false);
const switchEditModalVisibility = () => {
  isModalVisible.value = !isModalVisible.value;
};

const onClickOutsideCloseModal = (event: any) => {
  const modal = document.querySelector(".modal-edit-delete__container");
  const dotButton = document.querySelector(".button-icon-selector");
  // check user is not clicking on the modal or the dot button
  if (
    isModalVisible.value === true &&
    modal &&
    !modal.contains(event.target) &&
    dotButton &&
    !dotButton.contains(event.target)
  ) {
    switchEditModalVisibility();
  }
};
onMounted(() => {
  window.addEventListener("mousedown", onClickOutsideCloseModal);
});
// clean up even on unmount
onUnmounted(() => {
  window.removeEventListener("mousedown", onClickOutsideCloseModal);
});
</script>

<template>
  <section class="header-team__container">
    <div>
      <section>
        <figure>
          <img
            :src="teamImage"
            alt="" />
        </figure>
        <h1>{{ teamStore.getTeamSelected.teamName }}</h1>
      </section>

      <section>
        <button-text-icon
          @click.prevent="router.push({path: `invitation`})"
          :icon="addIcon"
          text="INVITATION" />

        <button-icon
          :icon="dotIcon"
          class="button-icon-selector"
          @click.prevent="switchEditModalVisibility" />

        <div
          :class="[
            'modal-edit-delete__container',
            isModalVisible ? 'modal-edit-delete__visible' : 'modal-edit-delete__hidden',
          ]">
          <modal-team-edit-delete />
        </div>
      </section>
    </div>
  </section>
</template>

<style scoped lang="scss">
.header-team__container {
  display: flex;
  flex-direction: column;
  gap: 16px;

  padding-block: 44px 24px;
  padding-inline: 40px;

  figure {
    background-color: black;
    width: 48px;
    height: 48px;
    border-radius: 16px;
    img {
      width: 100%;
      object-fit: contain;
    }
  }

  h1 {
    font-size: 40px;
    font-style: normal;
    font-weight: 500;
    line-height: 100%; /* 40px */
    letter-spacing: -2px;
  }

  > div {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
    //figure & text
    > section:nth-of-type(1) {
      display: flex;
      align-items: center;
      gap: 8px;
    }
    //buttons
    > section:nth-last-of-type(1) {
      display: flex;
      align-items: center;
      gap: 16px;

      position: relative;
    }
  }

  .modal-edit-delete__container {
    position: absolute;
    top: 130%;
    right: 0;
    transition: visibility 0s, opacity 0.25s ease;
  }

  .modal-edit-delete__hidden {
    visibility: hidden;
    opacity: 0;
  }

  .modal-edit-delete__visible {
    visibility: visible;
    opacity: 1;
  }
}
</style>
