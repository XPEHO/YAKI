<template>
  <slot name="pageContentHeader"></slot>

  <section class="content-wrapper">
    <slot name="content"></slot>
  </section>
</template>

<style scoped lang="scss">
.content-wrapper {
  display: flex;
  flex-direction: column;
  align-items: center;

  gap: 1.5rem;
}
</style>
