import { createApp } from "vue";
import { createPinia } from "pinia";
import { createI18n } from "vue-i18n";
import router from "./router/router";
import App from "./App.vue";
import "./assets/style/main.css";
import "../node_modules/@yaki_ui/yaki_ui_web_components/css/yaki_ui.css";

import enJson from "@/assets/translations/en.json";
import frJson from "@/assets/translations/fr.json";

const translations = {
  en: enJson,
  fr: frJson,
};

const i18n = createI18n({
  locale: "fr",
  fallbackLocale: "en",
  messages: translations,
  legacy: false,
  globalInjection: true,
});

const pinia = createPinia();
const app = createApp(App);
app.use(pinia);
app.use(i18n);
app.use(router);

app.mount("#app");
