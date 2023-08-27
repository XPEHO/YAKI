<script setup lang="ts">
import HeaderYaki from "@/features/shared/components/HeaderMain.vue";
import SideBar from "@/global-layouts/SideBar.vue";
import modalFrame from "@/features/shared/modal/ModalFrame.vue";
import modalState from "@/features/shared/modal/services/modalState";
</script>

<template>
  <modal-frame v-show="modalState.isShowed" />
  <header-yaki />
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
  // flex 1 to have this container take the rest of the screen space
  // See assets/style.scss @app {}
  flex: 1;
  display: grid;
  grid-template-columns: minmax(10rem, 17rem) minmax(80%, 1fr);
}
.page-content {
  padding: 30px;
  font-family: "Inter", sans-serif;
}
</style>
@/features/shared/modal/services/modalState
