<template>
  <div class="cercle-avatar">
    <div class="avatar">
      <span class="initials">{{ getInitials() }}</span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    firstName: {
      type: String,
      required: true,
    },
    lastName: {
      type: String,
      required: true,
    },
    avatarReference: {
      type: String,
      required: true,
    },
  },
  methods: {
    getInitials() {
      const firstInitial = this.firstName.charAt(0).toUpperCase();
      const lastInitial = this.lastName.charAt(0).toUpperCase();
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
