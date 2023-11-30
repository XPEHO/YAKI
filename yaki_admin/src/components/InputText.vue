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
  isError: {
    type: Boolean,
    required: false,
    default: false,
  },
});

const emit = defineEmits(["inputValue"]);

const onInputUse = (e: Event) => {
  emit("inputValue", (e.target as HTMLInputElement).value);
};

const classList = [
  "input__border-background",
  "input__container-flex",
  "input__container-height",
  "input__label-style",
];
</script>

<template>
  <section :class="[classList, props.isError ? 'input__error' : '']">
    <div class="input-warning"></div>
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

<style scoped lang="scss">
.input__error:after {
  content: "Please provide a name for your team.";
  position: absolute;
  bottom: 6%;
  left: 25px;
  font-size: 0.8rem;
  font-weight: 900;
  color: red;
}
</style>
