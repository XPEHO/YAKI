<script setup lang="ts">
const props = defineProps({
  innerText: {
    type: String,
    required: true,
  },
  iconPath: {
    type: String,
    required: true,
  },
});
</script>

<template>
  <button class="sidebar-button-specific sidebar-element-generic-style">
    <div>
      <figure>
        <img
          v-bind:src="iconPath"
          alt="Plus icon" />
      </figure>
      <p>{{ innerText }}</p>
    </div>
  </button>
</template>

<style scoped lang="scss">
.sidebar-button-specific {
  border: none;
  background-color: transparent;
  transition: background-color 0.2s;
  padding-block: 0.7rem;
  p {
    color: rgb(4, 3, 3);
  }
  &:active {
    background-color: rgb(218, 215, 215);
  }
}
</style>
