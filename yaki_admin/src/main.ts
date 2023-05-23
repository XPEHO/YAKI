import { createApp } from 'vue';
import { createPinia } from 'pinia';
import router from './router/router';
import App from './App.vue';
import './assets/style/style.css';

const pinia = createPinia();
const app = createApp(App);

app.use(router);
app.use(pinia);

app.mount('#app');
