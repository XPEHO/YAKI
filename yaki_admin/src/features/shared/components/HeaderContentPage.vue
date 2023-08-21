<script setup lang="ts">
const props = defineProps({
  title: {
    type: String,
    required: true,
  },
  text: {
    type: String,
    required: true,
  },
});
</script>
<template lang="">
  <h1 class="title">{{ title }}</h1>
  <h2 class="text">{{ text }}</h2>
  <hr class="line" />
</template>
<style lang="scss">
.title {
  font-size: 25px;
}
.text {
  font-size: 15px;
  color: #787878;
  margin-bottom: 20px;
}
.line {
  width: 80%;
  background-color: #efefefed;

  margin-bottom: 1rem;
}
</style>
