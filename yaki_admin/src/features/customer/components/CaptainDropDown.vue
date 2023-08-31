<script setup lang="ts">
import {useCaptainStore} from "@/stores/captainStore";
import {useTeamStore} from "@/stores/teamStore";
import {PropType, onBeforeMount, reactive, ref} from "vue";
import {CaptainDetails} from "@/models/team.type";

const captainStore = useCaptainStore();
const teamStore = useTeamStore();

const captainOfTheteam = defineProps({
  captain: {
    type: Object as PropType<CaptainDetails>,
  },
});

onBeforeMount(async () => {
  if (captainOfTheteam.captain !== undefined) {
    selectedCaptain.id = captainOfTheteam.captain.captainId;
    selectedCaptain.informations = `${captainOfTheteam.captain.lastName} ${captainOfTheteam.captain.firstName}`;
    buttonText.value = selectedCaptain.informations;
  }
});

const buttonText = ref("Captain selection");

interface SelectedCaptain {
  id: number | null;
  informations: string;
}

const selectedCaptain: SelectedCaptain = reactive({
  id: null,
  informations: "",
});

/**
 * get captainid and lastname & firstname from the captain list.
 * If the button text do not already display the selected captain informations, the new captain informations are saved.
 * Else if the same captain is selected, reset the display and captain informations. As it mean the user have unselected the current captain.
 * @param captainId
 * @param informations lastname and firstname concatenatio
 */
const getSelectedCaptain = (captainId: number, informations: string) => {
  if (buttonText.value !== selectedCaptain.informations) {
    selectedCaptain.id = captainId;
    selectedCaptain.informations = informations;
    buttonText.value = `${selectedCaptain.informations}`;

    teamStore.setCaptainIdToBeAssign(captainId);
  } else {
    selectedCaptain.id = 0;
    selectedCaptain.informations = "";
    buttonText.value = "Captain selection";

    teamStore.setCaptainIdToBeAssign(null);
  }
};

// display the checkIcon for the selected captain
const isCaptainSelected = (id: number | null): boolean => {
  return selectedCaptain.id === id;
};

// check if the captain list exist and is empty to replace the captain list with a message.
const isEmptyCaptainList = (): boolean => {
  return captainStore.getCaptainList !== undefined && captainStore.getCaptainList.length === 0;
};
</script>

<template>
  <section class="wrapper-captain-drop-down">
    <div class="button shared-setting">
      <div class="arrow-down"></div>
      <p>{{ buttonText }}</p>
    </div>
    <article class="drop-down-container">
      <!-- Empty Captain list -->
      <div
        v-if="isEmptyCaptainList()"
        class="drop-down-element shared-setting">
        <p class="italic">No captain available</p>
      </div>
      <!-- Captain list with data -->
      <div
        v-for="captain in captainStore.getCaptainList"
        class="drop-down-element shared-setting"
        @click.prevent="getSelectedCaptain(captain.captainId, `${captain.lastname} ${captain.firstname}`)"
        v-bind:key="captain.captainId">
        <div :class="isCaptainSelected(captain.captainId) ? 'check-icon' : 'check-icon-transparent'"></div>

        <p>{{ captain.lastname }} {{ captain.firstname }}</p>
      </div>
    </article>
  </section>
</template>

<style scoped lang="scss">
$font-size-button-drop-down: 0.85rem;
$font-size-drop-down-element: 0.9rem;

$font-weight-button-drop-down: 400;

$color-drop-down-border-color: rgb(230, 227, 227);

$transition-delay: 0.125s;

$modal-drop-down-element-padding: 1rem;

$font-size-captain-name: 0.85rem;
$font-weight-captain-name: 700;

.wrapper-captain-drop-down {
  position: relative;
  width: 100%;

  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  gap: 0.5rem;

  height: 2.5rem;

  &:hover {
    cursor: pointer;
  }
}

// button & drop-down-element
.shared-setting {
  display: flex;
  align-items: center;
  gap: 1rem;

  width: 100%;
}

.button {
  border: none;

  // delay hover
  transition-delay: $transition-delay;

  p {
    font-size: $font-size-captain-name;
    font-weight: $font-weight-captain-name;
    color: $font-color-main-text;
  }
}

.drop-down-container {
  visibility: hidden;
  position: absolute;
  top: 100%;
  right: 1rem;

  width: 100%;

  box-shadow: 20px 5px 10px 10px rgba(0, 0, 0, 0.292);

  // delay hover
  transition-delay: $transition-delay;
}

.drop-down-element {
  padding-block: 0.65rem;
  padding-inline: 1rem;

  background-color: white;
  border-top-color: transparent;

  &:hover {
    background-color: #326169;
  }

  p {
    font-size: $font-size-drop-down-element;
    color: $font-color-main-text;
  }
}

.italic {
  font-style: italic;
}

// ON HOVER STYLE --------------------------------------------------------

// on HOVER the container set DROP DOWN LIST visible
.wrapper-captain-drop-down:hover .drop-down-container {
  visibility: visible;
}

// on HOVER on element container change P color
.drop-down-element:hover p {
  color: $font-color-clear-gray;
}

.drop-down-element:hover .check-icon {
  @include check-icon-mixin(0.8rem, $font-color-clear-gray);
}

// ICONS ----------------------------------------------------------------
.arrow-down {
  @include arrow-down-mixin(8px, 9px, $color-drop-down-icons);
}

.check-icon {
  @include check-icon-mixin(0.8rem, $color-drop-down-icons);
}

.check-icon-transparent {
  @include check-icon-mixin(0.8rem, transparent);
}
</style>
