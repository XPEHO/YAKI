<script setup lang="ts">
import {useCaptainStore} from "@/stores/captainStore";
import {useSelectedRoleStore} from "@/stores/selectedRole";
import {onBeforeMount, onMounted, reactive, ref} from "vue";

const captainStore = useCaptainStore();
const selectedRoleStore = useSelectedRoleStore();

onBeforeMount(async () => {
  await captainStore.setAllCaptainsByCustomerId(selectedRoleStore.getCustomerIdSelected);
});

const buttonText = ref("Captain selection");

const selectedCaptain = reactive({
  id: 0,
  informations: "",
});

const getSelectedCaptain = (captainId: number, informations: string) => {
  if (buttonText.value !== selectedCaptain.informations) {
    selectedCaptain.id = captainId;
    selectedCaptain.informations = informations;
    buttonText.value = `${selectedCaptain.informations}`;
  } else {
    selectedCaptain.id = 0;
    selectedCaptain.informations = "";
    buttonText.value = "Captain selection";
  }
};

const isCaptainSelected = (id: number): boolean => {
  return selectedCaptain.id === id;
};
</script>

<template>
  <section class="body">
    <section class="wrapper">
      <div class="button shared-setting">
        <p>{{ buttonText }}</p>
        <div class="arrow-down"></div>
      </div>
      <article class="drop-down-container">
        <div
          v-if="captainStore.getCaptainList.length === 0"
          class="drop-down-element-container shared-setting">
          <p class="italic">No captain available</p>
        </div>
        <div
          v-for="captain in captainStore.getCaptainList"
          class="drop-down-element-container shared-setting"
          @click.prevent="getSelectedCaptain(captain.id, `${captain.lastname} ${captain.firstname}`)">
          <p>{{ captain.lastname }} {{ captain.firstname }}</p>
          <div
            v-if="isCaptainSelected(captain.id)"
            class="check-icon"></div>
        </div>
      </article>
    </section>
    <p class="annotation italic">Optional : Assign a captain to the team</p>
  </section>
</template>

<style scoped lang="scss">
$font-size-button-drop-down: 0.85rem;
$font-size-drop-down-element: 0.9rem;

$font-weight-button-drop-down: 400;

$color-drop-down-border-color: rgb(230, 227, 227);

$transition-delay: 0.125s;

$modal-drop-down-element-padding: 1rem;

// button & drop-down-element-container
.shared-setting {
  display: flex;
  justify-content: space-between;
  align-items: center;

  box-sizing: border-box;
  padding-inline: 1.5rem;

  width: 100%;
}

.body {
  margin-block-start: 1rem;

  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.wrapper {
  position: relative;
  width: 100%;
}

.button {
  padding-block: 0.8rem;

  gap: 0.5rem;

  background-color: white;
  border: 1px solid;
  border-color: $color-drop-down-border-color;

  border-radius: $modal-border-radius;

  // delay hover
  transition-delay: $transition-delay;

  p {
    color: $font-color-main-text;
    font-size: $font-size-button-drop-down;
    font-weight: $font-weight-button-drop-down;
    cursor: pointer;
  }
}

.drop-down-container {
  visibility: hidden;
  position: absolute;
  top: 100%;

  width: 100%;

  border-radius: 0px 0px $modal-border-radius $modal-border-radius;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.282);

  // delay hover
  transition-delay: $transition-delay;

  &:hover {
    cursor: pointer;
  }
}

.drop-down-element-container {
  padding-block: 0.65rem;

  background-color: $color-drop-down-border-color;

  border: 1px solid $color-drop-down-border-color;
  border-top-color: transparent;

  &:hover {
    background-color: rgb(167, 160, 160);
  }

  p {
    font-size: $font-size-drop-down-element;
    color: $font-color-main-text;
  }
}

.drop-down-element-container:nth-last-child(1) {
  border-radius: 0px 0px $modal-border-radius $modal-border-radius;
}

.annotation {
  width: min(100%, 12rem);
  font-size: 0.8rem;
}

.italic {
  font-style: italic;
}

// ON HOVER STYLE --------------------------------------------------------

// on HOVER the container change BUTTON style
.wrapper:hover .button {
  border-radius: $modal-border-radius $modal-border-radius 0px 0px;
  border-bottom-color: transparent;

  p {
    color: $font-color-main-text;
  }
}

// on HOVER the container set DROP DOWN LIST visible
.wrapper:hover .drop-down-container {
  visibility: visible;
}

// on HOVER on element container change P color
.drop-down-element-container:hover p {
  color: $font-color-clear-gray;
}

// ICONS ----------------------------------------------------------------
.arrow-down {
  @include arrow-down-mixin(8px, 9px, $color-drop-down-icons);
}

.check-icon {
  @include check-icon-mixin(0.8rem, $color-drop-down-icons);
}
</style>
