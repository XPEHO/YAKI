<script setup lang="ts">
import buttonPrimary from "@/ui/components/buttons/ButtonPrimary.vue";
import buttonSecondary from "@/ui/components/buttons/ButtonSecondary.vue";
import inputText from "@/ui/components/inputs/InputText.vue";
import inputPassword from "@/ui/components/inputs/InputPassword.vue";
import { useAuthStore } from "@/stores/authStore";
import { reactive, ref, watch } from "vue";

const usernamePlaceholder = "Login";
const passwordPlaceholder = "Password";

const isLloggingLoading = ref(false);
const isLoggingError = ref(false);

const form = reactive({
  username: "",
  password: "",
});

const onInputLogin = (value: string) => {
  form.username = value;
};

const onInputPassword = (value: string) => {
  form.password = value;
};

const login = async () => {
  const authStore = useAuthStore();
  if (form.username === "" || form.password === "") return;

  isLoggingError.value = false;
  isLloggingLoading.value = true;

  await authStore.login(form.username, form.password).then((res) => {
    if (!res) {
      isLoggingError.value = true;
    }
  });
};

watch(isLoggingError, (newValue) => {
  if (newValue) {
    isLloggingLoading.value = false;
  }
});

const forgottenPassword = () => {};
</script>

<template>
  <section class="login_form_container">
    <div :class="['loging_from_wrapper', isLoggingError ? 'logging_error' : '']">
      <p class="text_default__title_header">Administration</p>
      <form>
        <input-text
          :labelText="usernamePlaceholder"
          @emittedInput="onInputLogin"
        />

        <input-password
          :labelText="passwordPlaceholder"
          @emittedInput="onInputPassword"
        />

        <button-primary
          text="SIGN IN"
          @click.prevent="login"
          type="submit"
          :is-disabled="isLloggingLoading"
        />

        <div
          v-show="isLloggingLoading"
          :class="['loader', isLloggingLoading ? 'loader-animation' : '']"
        ></div>

        <buttonSecondary
          text="FORGOTTEN PASSWORD?"
          @click.prevent="forgottenPassword"
        />
      </form>
    </div>
  </section>
</template>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
.login_form_container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-self: center;
  gap: 2rem;

  width: 100%;
  height: 100%;

  form {
    display: flex;
    flex-direction: column;
    gap: 1.4rem;
    position: relative;
  }
}

.loging_from_wrapper {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-self: center;

  width: min(90%, 450px);

  > p {
    padding-inline-start: 2rem;
    padding-block-end: 4rem;
  }
}

.logging_error {
  position: relative;

  &:after {
    position: absolute;
    bottom: -15%;
    left: 10%;

    text-align: center;

    content: "Something went wrong. Please try again.";

    color: red;
    font-family: $font-sf-compact;
    font-size: 1.2rem;
  }
}
</style>
