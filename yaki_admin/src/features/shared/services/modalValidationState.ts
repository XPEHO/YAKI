import {reactive} from "vue";
import {h} from "vue";
import ModalValidation from "@/features/shared/popup/ModalValidation.vue";

const modalValidationState = reactive({
  isShowed: false as boolean,
  information: "" as string,

  testdisplay() {
    return h("div", {innerHTML: "hello"});
  },

  changeVisibility() {
    this.isShowed = !this.isShowed;
  },

  setInformation(data: string) {
    this.information = data;
  },
});

export default modalValidationState;
