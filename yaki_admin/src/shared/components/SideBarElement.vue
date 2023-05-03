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
  <section
    class="sidebar_element_specific sidebar_element_generic_style"
    :class="{'sidebar_active-class': isSelected}">
    <div>
      <figure>
        <img
          v-bind:src="iconPath"
          alt="" />
      </figure>
      <p>{{ innerText }}</p>
    </div>
  </section>
</template>

<style lang="scss">
.sidebar_element_specific {
  padding-block: 1rem;

  div {
    align-items: center;
  }

  p {
    color: rgb(239, 237, 237);
  }
}
</style>
