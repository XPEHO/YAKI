<script setup lang="ts">
const props = defineProps({
  icon: {
    type: String,
    required: true,
  },
});

const classList = ["button--general", "button--color-secondary", "button--height-secondary", "button--icon-text-style"];
</script>

<template>
  <button :class="classList">
    <figure>
      <img
        :src="icon"
        alt="arrow-left" />
    </figure>
  </button>
</template>
