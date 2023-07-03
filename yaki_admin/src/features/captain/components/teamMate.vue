<script lang="ts">
import {defineComponent} from "vue";
import type {TeamMateType} from "@/models/teamMate.type";

export default defineComponent({
  name: "TeamMate",
  props: {
    // The prop 'teamMate' is of type 'TeamMateType' and is required.
    teamMate: {
      type: Object as () => TeamMateType,
      required: true,
    },
  },
});
</script>

<template>
  <section class="team-mate">
    <div class="team-mate-avatar-info">
      <img
        class="avatar"
        src="../../../assets/avatar.png"
        alt="Avatar" />
      <div class="team-mate-info">
        <h1 class="name">{{ teamMate.firstName }} {{ teamMate.lastName }}</h1>
        <h2 class="email">{{ teamMate.email }}</h2>
      </div>
    </div>
    <div class="delete-edit-icon">
      <img
        class="team-mate-icon"
        src="../../../assets/Edit.png"
        alt="" />
      <img
        class="team-mate-icon"
        src="../../../assets/Delete.png"
        alt="" />
    </div>
  </section>
</template>

<style lang="scss">
.team-mate {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  justify-content: space-between;

  width: 60%;
}

.team-mate-avatar-info {
  display: flex;
  flex-direction: row;
  align-items: flex-end;
  gap: 2rem;
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

.delete-edit-icon {
  display: flex;
  gap: 2rem;
}
</style>
