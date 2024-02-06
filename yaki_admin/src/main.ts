import { createApp } from "vue";
import { createPinia } from "pinia";
import router from "./router/router";
import App from "./App.vue";
import "./assets/style/main.css";
import "../node_modules/@yaki_ui/yaki_ui_web_components/css/yaki_ui.css";

const pinia = createPinia();
const app = createApp(App);
app.use(pinia);
app.use(router);

app.mount("#app");
