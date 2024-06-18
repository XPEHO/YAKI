<script setup lang="ts"></script>

<template>
  <slot name="pageContentHeader"></slot>

  <section class="content-wrapper">
    <slot name="content"></slot>
  </section>
</template>

<style scoped lang="scss">
.content-wrapper {
  padding-inline: 40px;
  overflow: auto;

  @supports selector(::-webkit-scrollbar) {
    &::-webkit-scrollbar {
      width: 0.5rem;
      border-radius: 0.12rem;
      margin: 1rem;
      background-color: #d8d8d8;
    }

    &::-webkit-scrollbar-thumb {
      background-color: rgba(0, 0, 0, 0.15);
      border-radius: 0.12rem;
    }

    &::-webkit-scrollbar-thumb:hover {
      background-color: $background-color-theme-secondary;
    }
  }
  @supports not selector(::-webkit-scrollbar) {
    scrollbar-width: 8px;
    scrollbar-color: $background-color-theme-secondary transparent;
  }
}
</style>
