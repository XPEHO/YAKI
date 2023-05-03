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
  isSelected: {
    type: Boolean,
    required: true,
  },
});
</script>

<template>
  <button
    class="sidebar_button-specific sidebar_element_generic_style"
    :class="{'sidebar_active-class': isSelected}">
    <div>
      <figure>
        <img
          v-bind:src="iconPath"
          alt="" />
      </figure>
      <p>{{ innerText }}</p>
    </div>
  </button>
</template>

<style lang="scss">
.sidebar_button-specific {
  border: none;
  background-color: transparent;
  transition: background-color 0.2s;
  padding-block: 0.7rem;

  div {
    align-items: flex-start;
  }

  p {
    color: rgb(4, 3, 3);
  }

  &:active {
    background-color: rgb(218, 215, 215);
  }
}
</style>
