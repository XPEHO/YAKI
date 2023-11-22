<script setup lang="ts">
const props = defineProps({
  text: {
    type: String,
    required: true,
  },
});

const classList = [
  "button--general",
  "button--color-secondary",
  "button--height-secondary",
  "button--width-100-pct",
  "button--text",
  "text-uppercase",
  "unselectabla-text",
];
</script>

<template>
  <button :class="classList">
    {{ props.text }}
  </button>
</template>
