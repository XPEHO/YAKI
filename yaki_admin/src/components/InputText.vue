<script setup lang="ts">
const props = defineProps({
  labelText: {
    type: String,
    required: true,
  },
  inputValue: {
    type: String,
    required: true,
  },
});

const emit = defineEmits(["inputValue"]);

const onInputUse = (e: Event) => {
  emit("inputValue", (e.target as HTMLInputElement).value);
};
</script>

<template>
  <section class="input__border-background input__container-flex input__container-height input__label-style">
    <input
      @input="onInputUse"
      class="input__text input__no-border-background"
      type="text"
      placeholder=""
      :value="inputValue"
      id="input-text" />
    <label for="input-text">{{ props.labelText }}</label>
  </section>
</template>
