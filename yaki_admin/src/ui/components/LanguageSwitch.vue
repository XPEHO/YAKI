<script setup>
import { onMounted, ref } from "vue";
import { useI18n } from "vue-i18n";
const { locale } = useI18n();

const props = defineProps({
  version: {
    type: String,
  },
});

const languageSelected = ref("");

onMounted(() => {
  let storedLanguage = localStorage.getItem("language");
  const browserLanguage = navigator.language || navigator.languages[0];

  if (!storedLanguage) {
    // Save the selected language to local storage
    storedLanguage = browserLanguage.includes("fr") ? "fr" : "en";
  }

  locale.value = storedLanguage;
  languageSelected.value = storedLanguage;
});

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
    :class="[
      'language_switch_container',
      props.version ? props.version : '',
      languageSelected === 'en' ? 'toggle-position' : '',
    ]"
  >
    <p :class="languageSelected === 'fr' ? 'p_selected' : 'p_not_selected'">Fr</p>
    <p :class="languageSelected === 'fr' ? 'p_not_selected' : 'p_selected'">En</p>
  </section>
</template>

<style scoped lang="scss">
.language_switch_container {
  isolation: isolate;
  display: flex;
  justify-content: space-between;
  width: 60px;
  height: 30px;
  cursor: pointer;
  position: relative;

  p {
    font-family: $font-sf-compact;
    font-size: 1rem;
    font-weight: 700;
    padding: 0 0.5rem;
    z-index: 1;
    user-select: none;
    transition: all 0.25s ease-in-out;
  }
}

.p_selected {
  color: $font-color-main-text;
}

.p_not_selected {
  color: $font-color-sub-text;
}

.language_switch_container::after {
  content: "";
  position: absolute;
  width: 55%;
  height: 100%;
  transition: all 0.25s ease-in-out;
  transform: translateY(-10%);
  border-radius: 8px;
}

.toggle-position::after {
  transform: translate(95%, -10%);
}

.login.language_switch_container::after {
  background-color: $background-color-theme-secondary;
}

.sidebar.language_switch_container::after {
  background-color: $background-color-theme-primary;
}

.sidebar {
  margin: auto;
}
</style>
