<script>
import {useAuthStore} from "@/stores/authStore";

import eyesIcon from "@/assets/images/eye.png";
import btnClickSound from "@/assets/sound/btnClick.mp3";

export default {
  mounted() {
    this.audioContainer = document.getElementById("audioContainer");
  },
  data() {
    return {
      eyesIcon: eyesIcon,
      btnClickSound: btnClickSound,
      audioContainer: null,
      usernamePlaceholder: "Enter your login",
      passwordPlaceholder: "Enter your password",
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

    playAudio() {
      this.audioContainer.play();
    },

    login() {
      this.playAudio();
      const authStore = useAuthStore();
      if (this.form.username !== "" && this.form.password !== "") {
        return authStore.login(this.form.username, this.form.password).catch((error) => setErrors({apiError: error}));
      }
      return;
    },

    forgottenPassword() {
      this.playAudio();
    },
  },
};
</script>

<template>
  <form @submit.prevent="login">
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
      class="button-style-common button-style-primary button-text-main">
      Sign In
    </button>
    <button
      class="button-style-common button-style-secondary button-text-secondary"
      @click.prevent="forgottenPassword">
      Forgot password ?
    </button>
  </form>

  <audio id="audioContainer">
    <source
      v-bind:src="btnClickSound"
      type="audio/mpeg" />
  </audio>
</template>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
form {
  display: flex;
  justify-content: center;
  flex-direction: column;
  gap: 1rem;
  padding-block-start: 8rem;
  margin-inline: auto;
  width: min(90%, 400px);

  position: relative;

  label {
    font-size: 1.5rem;
    font-weight: bold;
    margin-bottom: 1rem;
  }

  input {
    padding-inline-start: 1rem;
    padding-block: 1.3rem;
    font-size: 1rem;
    border-radius: 16px;
    border: 1px solid #ccc;
  }

  input:nth-of-type(2) {
    margin-bottom: 1.5rem;
  }

  figure {
    width: 1.8rem;
    position: absolute;
    top: 54%;
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
