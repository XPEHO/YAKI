<template>
  <div class="teamMate">
    <div class="teamMateAvatarInfo">
      <img class="avatar" src="../../../assets/avatar.png" alt="Avatar">
      <div class="teamMateInfo">
        <h1 class="name">{{ teamMate.firstName }} {{ teamMate.lastName }}</h1>
        <h2 class="email">{{ teamMate.email }}</h2>
      </div>
    </div>
    <div class="deleteEditIcon">
      <img class="teamMateIcon" src="../../../assets/Edit.png" alt="">
      <img class="teamMateIcon" src="../../../assets/Delete.png" alt="">
    </div>
  </div>
</template>
  
<script lang="ts">
import { defineComponent } from 'vue';
import type { TeamMateType } from '../../../services/teamMate.type';
export default defineComponent({
  name: 'TeamMate',
  props: {
    // The prop 'teamMate' is of type 'TeamMateType' and is required.
    teamMate: {
      type: Object as () => TeamMateType,
      required: true,
    },
  },
});
</script>

<style>
.teamMate {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  width: 500px;
  justify-content: space-between;
  padding-bottom: 22px;
}
.teamMateInfo {
  display: flex;
  flex-direction: column;
}
.name {
  font-size: 18px;
}
.email {
  font-size: 15px;
  color: #787878;
}
.avatar {
  width: 44px;
  height: 44px;
}
.teamMateIcon {
  width: 24px;
  height: 24px;
}
.teamMateAvatarInfo {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  gap: 20px;
}
.deleteEditIcon {
  gap: 20px;
}
</style>