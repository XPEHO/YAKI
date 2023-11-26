<script setup lang="ts">
const props = defineProps({
  text: {
    type: String,
    required: true,
  },
  icon: {
    type: String,
    required: true,
  },
});

const classList = [
  "button--general",
  "button--color-primary",
  "button--sized-content",
  "button--height-secondary",
  "button--icon-text-style",
];
</script>

<template>
  <button :class="classList">
    <figure>
      <img
        :src="icon"
        alt="arrow-left" />
    </figure>
    <p class="button--text text-uppercase unselectabla-text">{{ text }}</p>
  </button>
</template>
