/// <reference types="vitest" />
import {fileURLToPath, URL} from "node:url";

import {defineConfig} from "vite";
import vue from "@vitejs/plugin-vue";

// https://vitejs.dev/config/
export default defineConfig({
  server: {
    cors: {
      origin: false,
    },
  },
  plugins: [vue()],
  resolve: {
    alias: {
      "@": fileURLToPath(new URL("./src", import.meta.url)),
    },
  },
  test: {
    environment : 'happy-dom',
    coverage: {
      reporter: ['text', 'lcov', 'html']
    },
  },
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `
          @import "./src/assets/style/_variables.scss";
        `,
      },
    },
  },
});
