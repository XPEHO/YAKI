<template>
  <div class="team-mate">
    <div class="team-mate-avatar-info">
      <img class="avatar" src="../../../assets/avatar.png" alt="Avatar">
      <div class="team-mate-info">
        <h1 class="name">{{ teamMate.firstName }} {{ teamMate.lastName }}</h1>
        <h2 class="email">{{ teamMate.email }}</h2>
      </div>
    </div>
    <div class="delete-edit-icon">
      <img class="team-mate-icon" src="../../../assets/Edit.png" alt="">
      <img class="team-mate-icon" src="../../../assets/Delete.png" alt="">
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
.team-mate {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  width: 500px;
  justify-content: space-between;
  padding-bottom: 22px;
}
.team-mate-info {
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
.team-mate-icon {
  width: 24px;
  height: 24px;
}
.team-mate-avatar-info {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  gap: 20px;
}
.delete-edit-icon {
  gap: 20px;
}
</style>