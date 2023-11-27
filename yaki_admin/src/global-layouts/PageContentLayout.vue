<template>
  <slot name="pageContentHeader"></slot>

  <section class="content-wrapper">
    <slot name="content"></slot>
  </section>
</template>

<style scoped lang="scss">
.content-wrapper {
  padding-inline: 40px;
  overflow: auto;

  scrollbar-width: thin;
  scrollbar-gutter: stable both-edges;
  scrollbar-color: rgba(3, 3, 3, 0.446) transparent;
}
</style>
