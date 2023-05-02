PageCaptain
<script setup lang="ts"></script>

<template>
  <nav class="router">
    <slot></slot>
  </nav>
</template>

<style lang="scss">
// see asset/style.scss for #app { style }

.router {
  background-color: rgb(43, 41, 41);

  padding: 2rem;
  display: flex;
  flex-direction: column;
  gap: 2rem;
}
</style>
