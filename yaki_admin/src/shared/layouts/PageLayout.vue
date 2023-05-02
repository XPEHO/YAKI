<script setup lang="ts">
import HeaderYaki from "../../shared/components/HeaderYaki.vue";
import SideBar from "../components/SideBar.vue";
import ContentCaptain from "@/features/captain/layouts/ContentCaptain.vue";
</script>

<template>
  <header-yaki />
  <section class="sidebar-content-container-grid">
    <SideBar>
      <slot name="slidebarContent"></slot>
    </SideBar>
    <slot name="content"></slot>
  </section>
</template>

<style lang="scss">
.sidebar-content-container-grid {
  // flex 1 to have this container take the rest of the screen space
  flex: 1;

  display: grid;
  grid-template-columns: minmax(10rem, 20rem) minmax(80%, 1fr);
}
</style>
