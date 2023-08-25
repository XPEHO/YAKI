<script setup lang="ts">
import modalState from "@/features/shared/services/modalState";
</script>

<template>
  <article class="modal-content-container modal-text">
    <p>{{ modalState.UserFirstLastName }}</p>
    <p>Is going to be removed from the team</p>
  </article>
</template>

<style lang="scss">
.modal-text {
  gap: 0.25rem;

  p {
    width: 65%;

    color: #303030;
    font-size: 1rem;
    font-family: Inter;
    font-weight: 700;
    text-align: center;
  }

  p:nth-child(1) {
    padding-block: 0.5rem;
    color: $font-color-main-text;
    font-size: 1.1rem;
    font-weight: 900;
  }

  p:nth-child(2) {
    padding-block: 0.5rem;
    font-size: 15px;
    color: $font-color-sub-text;
  }
}
</style>
