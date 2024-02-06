<script setup lang="ts">
import { BUTTONCOLORS } from "@/constants/componentsSettings.enum";

defineProps({
  text: {
    type: String,
    required: true,
  },
  icon: {
    type: String,
    required: true,
  },
  color: {
    type: String,
    required: false,
    default: BUTTONCOLORS.primary,
    validator: (value: string) => {
      return Object.values(BUTTONCOLORS).includes(value as BUTTONCOLORS);
    },
  },
});

const classList = [
  "button--general",
  "button--sized-content",
  "button--height-secondary",
  "button--icon-text-style",
];
</script>

<template>
  <button :class="[classList, color]">
    <figure>
      <img
        :src="icon"
        alt="arrow-left"
      />
    </figure>
    <p class="button--text text-uppercase unselectabla-text">{{ text }}</p>
  </button>
</template>
