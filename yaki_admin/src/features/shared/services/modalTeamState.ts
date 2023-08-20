import {reactive} from "vue";

const modalTeamState = reactive({
  isShowed: false as boolean,
  modalMode: 0 as number,
  teamInputValue: "" as string,
  selectedTeamName: "" as string,

  setTeamInputValue(inputvalue: string) {
    this.teamInputValue = inputvalue;
  },

  setSelectedTeamName(name: string) {
    this.selectedTeamName = name;
  },

  // when making modal visible change input text depending of edit or creation
  visibilitySwitch() {
    if (modalTeamState.modalMode === 1) {
      this.setTeamInputValue(this.selectedTeamName);
    } else {
      this.setTeamInputValue("");
    }
    this.isShowed = !this.isShowed;
  },

  // modalMode 0 = creation, 1 = edit, 2 = delete
  // Modal mode is used to change modal content
  setModalMode(mode: number) {
    this.modalMode = mode;
  },
});
export default modalTeamState;
