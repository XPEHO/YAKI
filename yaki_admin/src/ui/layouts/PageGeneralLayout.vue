<script setup lang="ts">
import modalFrameView from "@/ui/views/ModalFrameView.vue";
import { useModalStore } from "@/stores/modalStore";
import SideBarContent from "@/ui/views/SideBarContent.vue";

const modalStore = useModalStore();
</script>

<template>
  <transition name="fade">
    <modal-frame-view v-show="modalStore.getIsShow" />
  </transition>
  <section class="sidebar-content-container-grid">
    <!-- Common sidebar -->
    <side-bar-content />
    <!-- Content of the page -->
    <section class="page-content">
      <router-view />
    </section>
  </section>
</template>

<style scoped lang="scss">
@import url("https://fonts.googleapis.com/css2?family=Inter:wght@300&display=swap");
.sidebar-content-container-grid {
  display: grid;
  grid-template-columns: minmax(15rem, 20rem) 1fr;
  height: 100%;
}
.page-content {
  display: flex;
  flex-direction: column;

  background-color: $background-color-theme-primary;
  overflow: hidden;

  position: relative;
}

.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}
.fade-enter,
.fade-leave-to {
  opacity: 0;
}
</style>
