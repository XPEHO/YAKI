<script setup>
import { ref } from "vue";
import { useI18n } from "vue-i18n";
const { locale } = useI18n();

const languageSelected = ref("fr");

// Load the saved language from local storage or default to 'en'
locale.value = localStorage.getItem("language") || "fr";

const switchLanguage = () => {
  locale.value = locale.value === "en" ? "fr" : "en";
  // Save the selected language to local storage
  localStorage.setItem("language", locale.value);
  languageSelected.value = locale.value;
};
</script>

<template>
  <section
    @click.prevent="switchLanguage"
    :class="['language_switch_container', languageSelected === 'en' ? 'toggle-position' : '']"
  >
    <p>Fr</p>
    <p>En</p>
  </section>
</template>

<style lang="scss">
.language_switch_container {
  isolation: isolate;
  display: flex;
  justify-content: space-between;
  width: 60px;
  height: 90px;
  cursor: pointer;

  position: relative;

  p {
    font-family: $font-sf-compact;
    font-size: 1rem;
    font-weight: 700;
    padding: 0 0.5rem;
    z-index: 1;
  }
}

.language_switch_container::after {
  content: "";
  position: absolute;
  width: 55%;
  height: 40%;
  background-color: $background-color-theme-secondary;
  transition: all 0.2s ease-in-out;
  transform: translateY(-10%);
  border-radius: 8px;
}

.toggle-position::after {
  transform: translate(95%, -10%);
}
</style>
