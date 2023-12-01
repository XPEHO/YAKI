<script setup lang="ts">
const props = defineProps({
  icon: {
    type: String,
    required: true,
  },
  text: {
    type: String,
    required: true,
  },
  // by default false as its more likely to be used in the sidebar
  isModalElement: {
    type: Boolean,
    default: false,
  },
});

const defaultClassList = [
  "text-icon__container",
  "text-icon__container-height--padding",
  "text_icon--icon",
  "unselectabla-text",
];
</script>

<template>
  <div :class="[defaultClassList, isModalElement ? 'text-icon--background-white' : 'text-icon--sidebar-color']">
    <figure>
      <img
        :src="icon"
        alt="close" />
    </figure>
    <p class="text-icon--text">{{ props.text }}</p>
  </div>
</template>
