import { ref } from "vue";
import { useEventTargetListener } from "@/composable/useEventListener";

/**
 * Composition function that toggles the visibility of a modal when a button is clicked.
 * Close it when click is detected outside the modal.
 *
 * @param {string} modalSelector - The CSS class for the modal element used for querySelector.
 * @param {string} buttonSelector - The CSS class for the button that toggles the modal's visibility, used for querySelector.
 *
 * @returns {Object} An object with two properties:
 * - isModalVisible: A ref : the visibility state of the modal.
 * - switchModalVisibility: Toggle the ref value to define the modal visibility.
 *
 * The function sets up event listeners for 'mousedown' events on the window.
 * Used to detect clicks outside the modal and close it if it is open.
 * Event listeners are removed when the component is unmounted.
 */
export function useModalToggleWithOutsideClickHandler(
  modalSelector: string,
  buttonSelector: string,
) {
  const isModalVisible = ref(false);
  const switchModalVisibility = () => {
    isModalVisible.value = !isModalVisible.value;
  };

  const onClickOutsideCloseModal = (event: any) => {
    const modal = document.querySelector(modalSelector);
    const button = document.querySelector(buttonSelector);
    if (
      isModalVisible.value === true &&
      modal &&
      !modal.contains(event.target) &&
      button &&
      !button.contains(event.target)
    ) {
      switchModalVisibility();
    }
  };

  useEventTargetListener(window, "mousedown", onClickOutsideCloseModal);

  return { isModalVisible, switchModalVisibility };
}
