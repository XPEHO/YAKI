<script>
import {useAuthStore} from "@/stores/authStore";

import eyesIcon from "@/assets/images/eye.png";

export default {
  mounted() {
    this.audioContainer = document.getElementById("audioContainer");
  },
  data() {
    return {
      eyesIcon: eyesIcon,
      audioContainer: null,
      usernamePlaceholder: "Login",
      passwordPlaceholder: "Password",
      showPassword: false,
      form: {
        username: "",
        password: "",
      },
    };
  },
  methods: {
    togglePasswordVisibility() {
      this.showPassword = !this.showPassword;
    },

    onInputLogin(e) {
      this.usernameText = e.target.value;
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
  <form>
    <input
      type="text"
      v-model="form.username"
      @input="onInputLogin"
      :placeholder="usernamePlaceholder" />

    <input
      class="password-input"
      v-model="form.password"
      :type="showPassword ? 'text' : 'password'"
      :placeholder="passwordPlaceholder" />
    <figure>
      <img
        v-bind:src="eyesIcon"
        @click.prevent="togglePasswordVisibility" />
    </figure>
    <button
      type="submit"
      class="button-style-common button-style-primary button-text-main"
      @click.prevent="login">
      Sign In
    </button>
    <button
      class="button-style-common button-style-secondary button-text-secondary"
      @click.prevent="forgottenPassword">
      Forgot password ?
    </button>
  </form>
</template>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
form {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  padding-block-start: 8rem;
  margin-inline: auto;
  width: min(90%, 400px);

  position: relative;

  input {
    padding-inline-start: 2rem;
    padding-block: 1.3rem;
    font-size: $font-size-login-input;
    border-radius: 16px;
    border: 1px solid #ccc;

    &::placeholder {
      font-size: calc($font-size-login-input * 0.8);
    }
  }

  input:nth-of-type(2) {
    margin-bottom: 1.5rem;
  }

  figure {
    width: 1.4rem;
    position: absolute;
    top: 55%;
    right: 1%;
    transform: translate(-50%, -50%);

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }
  }
}

h3 {
  margin: 40px 0 0;
}
</style>
