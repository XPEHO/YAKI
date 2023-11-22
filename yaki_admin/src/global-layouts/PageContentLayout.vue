<template>
  <slot name="pageContentHeader"></slot>

  <section class="content-wrapper">
    <slot name="content"></slot>
  </section>
</template>

<style scoped lang="scss">
.content-wrapper {
  margin-top: 48px;
  padding-inline: 40px;
}
</style>
