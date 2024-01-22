import { setUserAvatarUrl } from '../../utils/images.utils';
<template>
  <div class="cercle-avatar">
    <div class="avatar">
      <span class="initials"> {{ initial }}</span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    firstname: {
      type: String,
      required: true,
    },
    lastname: {
      type: String,
      required: true,
    },
  },
  computed: {
    initial() {
      const firstInitial = this.firstname ? this.firstname.charAt(0) : "";
      const lastInitial = this.lastname ? this.lastname.charAt(0) : "";
      return `${firstInitial}${lastInitial}`;
    },
  },
};
</script>

<style scoped>
.cercle-avatar {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 50px;
  height: 50px;
}

.avatar {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 100%;
  height: 100%;
  border-radius: 50%;
  background-color: #ffd7c0;
}

.initials {
  font-size: 20px;
  font-weight: bold;
  color: #7d818c;
}
</style>
