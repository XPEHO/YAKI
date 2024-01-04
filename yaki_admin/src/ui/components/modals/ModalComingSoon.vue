<script setup lang="ts">
import { BUTTONCOLORS } from "@/constants/componentsSettings.enum";
import deleteIcon from "@/assets/images/x_close.png";
import ButtonTextIcon from "@/ui/components/buttons/ButtonTextIcon.vue";

const emit = defineEmits(["close"]);

const closeModal = async () => {
  emit("close");
};
</script>

<template>
  <section class="modal__container modal__delete-size">
    <h1 class="modal__container-title">Coming soon</h1>
    <div class="modal__location-button">
      <button-text-icon
        :text="'CLOSE'"
        :icon="deleteIcon"
        :color="BUTTONCOLORS.delete"
        @click.prevent="closeModal"
      />
    </div>
  </section>
</template>
