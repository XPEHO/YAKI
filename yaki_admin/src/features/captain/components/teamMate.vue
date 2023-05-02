<template>
  <div class="teamMate">
    <img class="avatar" src="../../../assets/avatar.png" alt="Avatar">
    <div class="teamMateInfo">
      <h1 class="name">{{ teamMate.firstName }} {{ teamMate.lastName }}</h1>
      <h2 class="email">{{ teamMate.email }}</h2>
    </div>
    <img src="../../../assets/Edit.png" alt="">
    <img src="../../../assets/Delete.png" alt="">
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
.teamMate{
  display: flex;
  flex-direction: row;
}
.teamMateInfo{
  display: flex;
  flex-direction: column;

}
.name {
  font-size: 20px;
}

.email {
  font-size: 15px;
  color: #787878;
}
.avatar{
  width: 56px;
  height: 56px;
}
</style>