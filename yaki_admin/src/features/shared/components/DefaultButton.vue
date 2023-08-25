<script setup lang="ts">
const props = defineProps({
  text: {
    type: String,
    required: true,
  },
  cssClass: {
    type: String,
    required: true,
  },
});
</script>

<template>
  <button v-bind:class="cssClass">{{ props.text }}</button>
</template>
