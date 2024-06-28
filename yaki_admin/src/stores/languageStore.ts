import { defineStore } from "pinia";

interface State {
  language: string | null;
}

export const useLanguageStore = defineStore("languageStore", {
  state: () => ({
    //the current language used by the website
    language: localStorage.getItem("language"),
  }),

  getters: {
    getLanguage: (state: State) => state.language,
  },

  actions: {
    // allows to set the current language option
    async setLanguage(newLanguage: string) {
      this.language = newLanguage;
      localStorage.setItem("language", newLanguage);
    },
  },
});
