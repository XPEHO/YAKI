<script>
import buttonPrimary from "@/ui/components/buttons/ButtonPrimary.vue";
import buttonSecondary from "@/ui/components/buttons/ButtonSecondary.vue";
import inputText from "@/ui/components/inputs/InputText.vue";
import inputPassword from "@/ui/components/inputs/InputPassword.vue";
import {useAuthStore} from "@/stores/authStore";

export default {
  components: {
    buttonPrimary,
    buttonSecondary,
    inputText,
    inputPassword,
  },
  mounted() {
    this.audioContainer = document.getElementById("audioContainer");
  },
  data() {
    return {
      usernamePlaceholder: "Login",
      passwordPlaceholder: "Password",
      form: {
        username: "",
        password: "",
      },
    };
  },
  methods: {
    onInputLogin(value) {
      this.form.username = value;
    },

    onInputPassword(value) {
      this.form.password = value;
    },

    login() {
      const authStore = useAuthStore();
      if (this.form.username !== "" && this.form.password !== "") {
        return authStore.login(this.form.username, this.form.password).catch((error) => setErrors({apiError: error}));
      }
      return;
    },
    forgottenPassword() {},
  },
};
</script>

<template>
  <section class="login_form_container">
    <div>
      <p class="login-title">Administration</p>
      <form>
        <input-text
          :labelText="usernamePlaceholder"
          @emittedInput="onInputLogin" />

        <input-password
          :labelText="passwordPlaceholder"
          @emittedInput="onInputPassword" />

        <button-primary
          text="SIGN IN"
          @click.prevent="login"
          type="submit" />
        <buttonSecondary
          text="FORGOTTEN PASSWORD?"
          @click.prevent="forgottenPassword" />
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
  }

  form {
    display: flex;
    flex-direction: column;
    gap: 1.4rem;
  }
}
.login-title {
  font-size: 2rem;
  font-weight: bold;
  padding-inline-start: 2rem;
  padding-block-end: 4rem;
}
</style>
