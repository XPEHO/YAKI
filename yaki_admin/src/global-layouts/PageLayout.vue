<script setup lang="ts">
import HeaderYaki from "@/features/shared/components/HeaderMain.vue";
import SideBar from "@/global-layouts/SideBar.vue";
</script>

<template>
  <header-yaki />
  <section class="sidebar-content-container-grid">
    <side-bar>
      <slot name="sidebarContent"></slot>
    </side-bar>
    <slot name="pageContent"></slot>
  </section>
</template>

<style scoped lang="scss">
.sidebar-content-container-grid {
  // flex 1 to have this container take the rest of the screen space
  // See assets/style.scss @app {}
  flex: 1;
  display: grid;
  grid-template-columns: minmax(10rem, 20rem) minmax(80%, 1fr);
}
</style>
