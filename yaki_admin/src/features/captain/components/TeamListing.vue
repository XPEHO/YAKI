<script setup lang="ts">
const props = defineProps({
  teamName: {
    type: String,
    required: true,
  },
});

//https://stackoverflow.com/questions/64514351/vue-3-setup-reactive-fetch-with-async-json
</script>

<template>
  <div class="team-list-unit">
    <p>{{ teamName }}</p>
    <figure>
      <img src="../../../assets/Edit.png" />
    </figure>
    <figure>
      <img src="../../../assets/delete.png" />
    </figure>
  </div>
</template>

<style lang="scss">
.team-list-unit {
  display: flex;
}
</style>
