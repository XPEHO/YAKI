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
  //
  /**
   * Parameter to check if the component is used in a modal
   * Which will determine css class related to background color and hover effect
   * By default false, meaning it is used in the sidebar.
   */
  isModalElement: {
    type: Boolean,
    default: false,
  },
  isUserAutorized: {
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
  <div
    :class="[
      defaultClassList,
      isModalElement
        ? 'text-icon--background-white'
        : isUserAutorized
          ? 'text-icon--sidebar-color'
          : '',
      isUserAutorized ? '' : 'menu-link-disable',
    ]"
  >
    <figure>
      <img
        :src="icon"
        alt="close"
      />
    </figure>
    <p class="text-icon--text">{{ props.text }}</p>
  </div>
</template>

<style scoped lang="scss">
.menu-link-disable {
  figure {
    img {
      filter: invert(0.8) brightness(0.5);
    }
  }

  p {
    color: rgb(113, 104, 104);
  }

  cursor: default;
}
</style>
