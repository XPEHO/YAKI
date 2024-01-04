<script setup lang="ts">
import { BUTTONCOLORS } from "@/constants/componentsSettings.enum";

const props = defineProps({
  text: {
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

const classList = ["button--general", "button--height-secondary", "button--inline-padding-16"];
</script>

<template>
  <button :class="[classList, color]">
    <p class="button--text text-uppercase unselectabla-text">{{ text }}</p>
  </button>
</template>
