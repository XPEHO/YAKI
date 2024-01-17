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
  isDisabled: {
    type: Boolean,
    required: false,
    default: false,
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
  <button
    :class="[classList, color, isDisabled ? 'button_disabled' : '']"
    :disabled="isDisabled"
  >
    <p :class="[isDisabled ? 'fade_out_text_animation' : '']">{{ text }}</p>
  </button>
</template>

<style scoped lang="scss">
.button_disabled {
  transform: translateY(var(--animation-translate-y-button));
  box-shadow: 0px 0px 0px 0px rgba(0, 0, 0, 0.15);
}
</style>
