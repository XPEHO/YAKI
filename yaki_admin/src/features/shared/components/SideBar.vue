<script setup lang="ts"></script>

<template>
  <nav class="navbar">
    <slot> </slot>
  </nav>
</template>

<style lang="scss">
.navbar {
  background-color: #fafafa;
  padding-block: 2rem;
  display: flex;
  flex-direction: column;
  gap: 2rem;
}
</style>
