import {onMounted, onUnmounted} from "vue";

type EventType = keyof HTMLElementEventMap;
type EventListener = (evt: HTMLElementEventMap[EventType]) => void;

/**
 * Composable function that adds an event listener to a target object when the component is mounted,
 * and removes it when the component is unmounted.
 *
 * @param target - The target object to which the event listener will be added. Any object such as an HTMLElement or the Window object.
 * @param event - The event type to listen to. Key of the HTMLElementEventMap.
 * @param callback - The event listener function called when the event activated.
 */
export function useEventTargetListener(target: EventTarget, event: EventType, callback: EventListener) {
  onMounted(() => {
    target.addEventListener(event, callback);
  });
  onUnmounted(() => {
    target.removeEventListener(event, callback);
  });
}
