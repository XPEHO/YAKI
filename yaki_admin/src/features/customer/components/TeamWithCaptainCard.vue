<script setup lang="ts">
import {TeamType} from "@/models/team.type";
import {PropType, ref} from "vue";

import modalState from "@/features/modal/services/modalState";
import {useTeamStore} from "@/stores/teamStore";

import EditAndDeleteButtons from "@/features/shared/components/EditAndDeleteButtons.vue";
import CaptainDropDown from "@/features/customer/components/CaptainDropDown.vue";

import user from "@/assets/images/user-filled.png";
import noUser from "@/assets/images/user-x.png";

const isEdit = ref(false);
const teamStore = useTeamStore();

const props = defineProps({
  teamContent: {
    type: Object as PropType<TeamType>,
    required: true,
  },
});

const acceptFunc = async () => {
  await teamStore.updateTeam(props.teamContent.id, teamStore.getCaptainIdToBeAssign, modalState.teamInputValue, null, null);
  isEdit.value = !isEdit.value;
  await teamStore.setTeamsFromCustomer();
};

const editFunc = () => {
  modalState.setTeamInputValue(props.teamContent.teamName);
  if (props.teamContent.captains.length > 0) {
    teamStore.setCaptainIdToBeAssign(props.teamContent.captains[0].captainId);
  }

  isEdit.value = !isEdit.value;
};

const deleteFunc = async () => {
  await teamStore.deleteTeam(props.teamContent.id);
  await teamStore.setTeamsFromCustomer();
};

const setTeamName = (e: Event) => {
  let input = (e.target as HTMLInputElement).value;
  modalState.setTeamInputValue(input.toString());
};

const isCaptain = () => {
  return props.teamContent.captains.length > 0
    ? `${props.teamContent.captains[0].firstName} ${props.teamContent.captains[0].lastName}`
    : "No captain assigned";
};
const captainNameCss = () => {
  return props.teamContent.captains.length > 0 ? "information-captain" : "no-captain";
};
</script>
<template>
  <section :class="['wrapper-team-captain', isEdit ? 'bg-color-edit' : 'bg-color']">
    <div>
      <section
        v-if="isEdit == false"
        class="section-texts">
        <p class="information-team">{{ teamContent.teamName }}</p>
        <div class="container-icon-name">
          <figure>
            <img
              :src="props.teamContent.captains.length > 0 ? user : noUser"
              alt="" />
          </figure>
          <p v-bind:class="captainNameCss()">{{ isCaptain() }}</p>
        </div>
      </section>

      <section
        v-if="isEdit == true"
        class="section-texts">
        <input
          type="text"
          :value="teamContent.teamName"
          @input="setTeamName" />
        <div class="container-icon-name">
          <captain-drop-down :captain="teamContent.captains[0]" />
        </div>
      </section>
      <!--  -->
    </div>

    <edit-and-delete-buttons
      :use-accept-button="true"
      @accept="acceptFunc"
      @edit="editFunc"
      @delete="deleteFunc" />
  </section>
</template>

<style scoped lang="scss">
$font-size-team-name: 1.1rem;
$font-weight-team-name: 800;
$font-size-captain-name: 0.85rem;
$font-weight-captain-name: 700;

$heigth-team-captain: 4.3rem;

.bg-color {
  background-color: $color-modal-background;
}

.bg-color-edit {
  background-color: $color-background-team-customer-card;
}

.wrapper-team-captain {
  width: min(90%, 30rem);

  padding-inline: 2rem;
  padding-block: 0.9rem;
  border-radius: $modal-border-radius;

  display: flex;
  justify-content: space-between;
  align-items: center;

  flex: 1;

  > div:nth-child(1) {
    height: $heigth-team-captain;
    flex: 1;
    display: flex;
    align-items: center;
  }
}

.section-texts {
  height: 100%;

  display: flex;
  flex-direction: column;
  align-items: flex-start;
  justify-content: space-between;
}

// --------------------------------------

.information-team {
  font-size: $font-size-team-name;
  font-weight: $font-weight-team-name;
  color: $font-color-main-text;
}

.container-icon-name {
  display: flex;
  flex-direction: row;
  align-items: center;
  gap: 0.5rem;

  padding-inline-start: 3rem;

  height: 1.5rem;

  figure {
    width: 1.65rem;
    img {
      width: 100%;
      object-fit: contain;
    }
  }
}

.information-captain {
  font-size: $font-size-captain-name;
  font-weight: $font-weight-captain-name;
  color: $font-color-main-text;
}

.no-captain {
  font-size: 0.9rem;
  color: $font-color-sub-text;
  font-style: italic;
}

// --------------------------------------

.wrapper-team-captain {
  input {
    border: none;
    border-bottom: 1px solid $font-color-sub-text;
    background-color: $color-background-team-customer-card;

    padding-inline-start: 0.5rem;
    padding-block-end: 0.1rem;

    font-size: $font-size-team-name;
    letter-spacing: 0.03rem;
    color: $font-color-main-text;

    &:focus {
      outline: none;
    }
  }
}
</style>
@/features/modal/services/modalState
