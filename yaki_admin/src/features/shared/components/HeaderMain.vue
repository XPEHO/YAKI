<script setup lang="ts">
import Logo from "@/assets/images/LOGO.png";
</script>

<template>
  <header class="header-yaki">
    <figure>
      <img v-bind:src="Logo" />
    </figure>
  </header>
</template>

<style scoped lang="scss">
.header-yaki {
  background-color: #32353c;
  display: flex;
  align-items: center;

  padding: 0.5rem;

  figure {
    width: 3rem;
    img {
      width: 100%;
      aspect-ratio: 1/1;
    }
  }
}
</style>
