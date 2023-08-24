<template>
  <nav class="sidebar">
    <slot> </slot>
  </nav>
</template>

<style scoped lang="scss">
.sidebar {
  background-color: $color-side-bar-background;
  padding-block: 2rem;
  display: flex;
  flex-direction: column;
  gap: 1rem;
}
</style>
