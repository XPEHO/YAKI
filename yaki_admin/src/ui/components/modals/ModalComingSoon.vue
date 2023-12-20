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
  <section class="modal-background">
    <dialog class="modal-container">
      <h2>Coming soon</h2>
      <button-text-icon
        :text="'CLOSE'"
        :icon="deleteIcon"
        :color="BUTTONCOLORS.delete"
        @click.prevent="closeModal" />
    </dialog>
  </section>
</template>
