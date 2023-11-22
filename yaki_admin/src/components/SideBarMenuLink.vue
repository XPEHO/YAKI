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
});
</script>

<template>
  <div class="text-icon__container text-icon__container-height--padding text_icon--icon text-icon--sidebar-color">
    <figure>
      <img
        :src="icon"
        alt="close" />
    </figure>
    <p class="text-icon--text">{{ props.text }}</p>
  </div>
</template>
