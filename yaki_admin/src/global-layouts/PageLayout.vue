<script setup lang="ts">
import SideBar from "@/global-layouts/SideBar.vue";
import modalFrame from "@/features/shared/modal/ModalFrame.vue";
import modalState from "@/features/shared/modal/services/modalState";
</script>

<template>
  <modal-frame v-show="modalState.isShowed" />
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
  padding: 30px;
  background-color: $background-color-theme-primary;
}
</style>
