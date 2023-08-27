<template>
  <nav class="sidebar">
    <slot> </slot>
  </nav>
</template>

<style scoped lang="scss">
.sidebar {
  background-color: $color-side-bar-background;
  padding-block-start: 2.5rem;
  display: flex;
  flex-direction: column;
  gap: 2rem;
}
</style>
