<script setup lang="ts">
import HeaderYaki from "@/features/shared/components/HeaderMain.vue";
import LoginForm from "@/features/login/components/LoginForm.vue";
</script>

<template>
  <header-yaki />
  <figure class="banner-figure">
    <img
      class="banner"
      src="../../../assets/banner2.png" />
  </figure>

  <login-form />
</template>

<style scoped lang="scss">
$borders: 0.5rem;
.banner-figure {
  background-color: #f5cd3d;
  width: 100%;
  max-height: 12rem;
  border-bottom-left-radius: $borders;
  border-bottom-right-radius: $borders;

  img {
    width: 100%;
    height: 100%;
    object-fit: contain;
    border-bottom: 16px;
  }
}
</style>
