export default {
  beforeMount(element: any, binding: { value: (arg0: MouseEvent | KeyboardEvent) => void }) {
    element.clickOutsideEvent = function (e: MouseEvent | KeyboardEvent) {
      /* Check if the event element or its children are either clicked upon or involved 
            in a keypress are the one defined in the directive*/

      if (!(element === e.target || element.contains(e.target))) {
        // Invoke the provided method
        binding.value(e);
      }
    };
    document.addEventListener("click", element.clickOutsideEvent);
    document.addEventListener("keydown", element.clickOutsideEvent);
  },
  unmounted(element: any) {
    // Remove the event listener when the bound element is unmounted
    document.removeEventListener("click", element.clickOutsideEvent);
    document.removeEventListener("keydown", element.clickOutsideEvent);
  },
};
