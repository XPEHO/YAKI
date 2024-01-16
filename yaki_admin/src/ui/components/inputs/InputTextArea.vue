<script setup lang="ts">
defineProps({
  labelText: {
    type: String,
    required: true,
  },
  inputValue: {
    type: String,
    required: true,
  },
});

const emit = defineEmits<{ emittedInput: [value: string] }>();

const onInputUse = (e: Event) => {
  emit("emittedInput", (e.target as HTMLInputElement).value);
};
</script>

<template>
  <section
    class="input__border-background input__container-flex textarea__container-height-pos input__label-style"
  >
    <textarea
      @input="onInputUse"
      :value="inputValue"
      class="input__text input__no-border-background"
      placeholder=""
      id="textarea"
      cols="10"
      rows="5"
    ></textarea>
    <label for="textarea">Text area label</label>
  </section>
</template>
