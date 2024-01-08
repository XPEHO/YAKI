<script setup lang="ts">
import buttonPrimary from "@/ui/components/buttons/ButtonPrimary.vue";
import buttonSecondary from "@/ui/components/buttons/ButtonSecondary.vue";
import inputText from "@/ui/components/inputs/InputText.vue";
import inputPassword from "@/ui/components/inputs/InputPassword.vue";
import { useAuthStore } from "@/stores/authStore";
import { reactive } from "vue";

const usernamePlaceholder = "Login";
const passwordPlaceholder = "Password";
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

const login = () => {
  const authStore = useAuthStore();
  if (form.username !== "" && form.password !== "") {
    return authStore.login(form.username, form.password).catch((error) => console.warn(error));
  }
  return;
};

const forgottenPassword = () => {};
</script>

<template>
  <section class="login_form_container">
    <div>
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
        />
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

  div {
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

  form {
    display: flex;
    flex-direction: column;
    gap: 1.4rem;
  }
}
</style>
