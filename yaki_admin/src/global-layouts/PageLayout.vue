<script setup lang="ts">
import SideBar from "@/global-layouts/SideBar.vue";
import modalFrame from "@/features/modal/ModalFrame.vue";
import modalState from "@/features/modal/services/modalState";
</script>

<template>
  <transition name="fade">
    <modal-frame v-show="modalState.isShowed" />
  </transition>
  <section class="sidebar-content-container-grid">
    <side-bar>
      <slot name="sidebarContent"></slot>
    </side-bar>
    <section class="page-content">
      <slot name="pageContent"></slot>
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
  padding-block-start: 44px;

  background-color: $background-color-theme-primary;
  overflow: hidden;
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
@/features/modal/services/modalState
