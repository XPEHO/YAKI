import {reactive} from "vue";

const modalState = reactive({
  isShowed: false as boolean,
  information: "" as string,

  changeVisibility() {
    this.isShowed = !this.isShowed;
  },

  setInformation(data: string) {
    this.information = data;
  },
});

export default modalState;
