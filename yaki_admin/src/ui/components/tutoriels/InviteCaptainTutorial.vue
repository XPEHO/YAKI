<script setup lang="ts">
import { useI18n } from "vue-i18n";
const { locale } = useI18n();
</script>

<template>
  <section>
    <p class="p-tutoriel-common p-tutoriel-main">{{ $t("tutorials.captainTitle") }}</p>
    <p class="p-tutoriel-common p-tutoriel-secondary margin-top-3">
      {{ $t("tutorials.captainContent1") }}
    </p>
    <p class="p-tutoriel-common p-tutoriel-secondary">
      {{ $t("tutorials.captainContent2") }}
    </p>

    <p
      v-if="locale == 'en'"
      class="p-tutoriel-common p-tutoriel-secondary margin-top-2"
    >
      <span class="color-primary">{{ $t("tutorials.invit") }}</span>
      {{ $t("tutorials.button") }}
    </p>

    <p
      v-else
      class="p-tutoriel-common p-tutoriel-secondary margin-top-2"
    >
      {{ $t("tutorials.button") }}
      <span class="color-primary">{{ $t("tutorials.invit") }}</span>
    </p>
  </section>
</template>

<style scoped lang="scss">
section {
  padding-block-start: 12rem;

  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;

  p:nth-of-type(3) {
    margin-top: 0.3rem;
  }

  .color-primary {
    font-size: 1.4rem;
    color: $background-color-theme-secondary;
    margin-inline: 0.2rem;
  }
}
</style>
