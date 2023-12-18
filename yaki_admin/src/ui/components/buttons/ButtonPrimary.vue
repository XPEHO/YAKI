<script setup lang="ts">
import {BUTTONCOLORS} from "@/constants/componentsSettings.enum";

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

const classList = [
  "button--general",
  "button--height-primary",
  "button--width-100-pct",
  "button--text",
  "text-uppercase",
  "unselectabla-text",
];
</script>

<template>
  <button :class="[classList, color]">
    {{ props.text }}
  </button>
</template>
