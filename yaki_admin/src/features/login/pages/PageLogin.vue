<script setup lang="ts">
import PageLayout from "../layouts/PageLoginLayout.vue";
import LoginForm from "@/features/login/components/LoginForm.vue"
</script>

<template>
  <PageLayout>
  </PageLayout>
  <figure>
      <img class="banner" src="../../../assets/banner2.png" />
      <LoginForm>
      </LoginForm>
    </figure>
</template>

<style lang="scss">
figure {
    .banner {
      width: 100%;
      display: block;
    }
  }
</style>