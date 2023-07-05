import {createApp} from "vue";
import {createPinia} from "pinia";
import router from "./router/router";
import App from "./App.vue";
import "./assets/style/style.css";

const pinia = createPinia();
const app = createApp(App);
app.use(pinia);
app.use(router);

app.mount("#app");
