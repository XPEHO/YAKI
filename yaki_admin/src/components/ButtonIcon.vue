<script setup lang="ts">
import {BUTTONCOLORS} from "@/constants/componentsSettings";

const props = defineProps({
  icon: {
    type: String,
    required: true,
  },
  color: {
    type: String,
    required: false,
    default: BUTTONCOLORS.secondary,
    validator: (value: string) => {
      return Object.values(BUTTONCOLORS).includes(value as BUTTONCOLORS);
    },
  },
});

const classList = ["button--general", "button--height-secondary", "button--icon-text-style"];
</script>

<template>
  <button :class="[classList, color]">
    <figure>
      <img
        :src="icon"
        alt="arrow-left" />
    </figure>
  </button>
</template>
