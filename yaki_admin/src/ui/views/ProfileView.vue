<script setup lang="ts">
import router from "@/router/router";
import buttonSecondary from "@/ui/components/buttons/ButtonSecondary.vue";

const logOff = () => {
  router.push("/");
};
</script>

<template>
  <section class="profile_container">
    <h1>Profile</h1>
    <p>Coming Soon</p>
    <buttonSecondary
      text="Log off"
      @click.prevent="logOff"
    />
  </section>
</template>

<style scoped lang="scss">
.profile_container {
  display: flex;
  flex-direction: column;
  gap: 16px;
  justify-content: space-between;
  padding: 2rem;

  h1 {
    font-size: 40px;
    font-style: normal;
    font-weight: 500;
    line-height: 100%; /* 40px */
    letter-spacing: -2px;
  }

  button {
    max-width: 10rem;
    margin: 2rem;
    align-self: center;
  }
}
</style>
