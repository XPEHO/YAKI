<script setup lang="ts">
import { ref } from "vue";
import eyesClosedIcon from "@/assets/icons_svg/Eye.svg";
import eyesOpenedIcon from "@/assets/icons_svg/Eye.svg";

const props = defineProps({
  labelText: {
    type: String,
    required: true,
  },
});

const emit = defineEmits<{ emittedInput: [value: string] }>();

const onInputUse = (e: Event) => {
  emit("emittedInput", (e.target as HTMLInputElement).value);
};

const isPasswordVisible = ref(false);

const switchPasswordVisibility = () => {
  isPasswordVisible.value = !isPasswordVisible.value;
};
</script>

<template>
  <section
    class="input__border-background input__container-flex input__container-height input__label-style"
  >
    <input
      @input="onInputUse"
      class="input__text input__no-border-background"
      v-bind:type="isPasswordVisible ? 'text' : 'password'"
      placeholder=""
      id="input-pw"
    />
    <label for="input-pw"> {{ labelText }}</label>
    <button
      @click.prevent="switchPasswordVisibility"
      class="input__password-btn-switch"
      type="button"
    >
      <figure>
        <img
          :src="isPasswordVisible ? eyesClosedIcon : eyesOpenedIcon"
          alt="button_password_visibility"
        />
      </figure>
    </button>
  </section>
</template>
