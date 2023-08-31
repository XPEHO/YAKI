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
  <section class="sidebar-element-specific sidebar-element-generic-style sidebar-active-class">
    <div>
      <figure>
        <img
          v-bind:src="iconPath"
          alt="teams icons" />
      </figure>
      <p>{{ innerText }}</p>
    </div>
  </section>
</template>

<style scoped lang="scss">
.sidebar-element-specific {
  padding-block: 1rem;

  div {
    align-items: center;
  }
  p {
    color: $font-color-clear-gray;
  }
}
</style>
