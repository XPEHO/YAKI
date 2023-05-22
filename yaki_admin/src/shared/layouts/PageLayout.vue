<script setup lang="ts">
import HeaderYaki from '../../shared/components/HeaderYaki.vue';
import SideBar from '../components/SideBar.vue';
import SideBarButton from '@/shared/components/SideBarButton.vue';

import plusIcon from '@/assets/plus.png';
</script>

<template>
  <header-yaki />
  <section class="sidebar-content-container-grid">
    <side-bar>
      <slot name="sidebarContent"></slot>
      <side-bar-button
        v-bind:inner-text="'Add team'"
        v-bind:icon-path="plusIcon"
      />
    </side-bar>
    <slot name="pageContent"></slot>
  </section>
</template>

<style lang="scss">
.sidebar-content-container-grid {
  // flex 1 to have this container take the rest of the screen space
  // See assets/style.scss @app {}
  flex: 1;
  display: grid;
  grid-template-columns: minmax(10rem, 20rem) minmax(80%, 1fr);
}
</style>
