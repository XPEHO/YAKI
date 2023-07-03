<script setup lang="ts">
import HeaderYaki from "@/features/shared/components/HeaderYaki.vue";
import LoginForm from "@/features/login/components/LoginForm.vue";
</script>

<template>
  <header-yaki />
  <img
    class="banner"
    src="../../../assets/banner2.png" />
  <login-form />
</template>

<style lang="scss">
.banner {
  width: 100%;
  display: block;
}
</style>
