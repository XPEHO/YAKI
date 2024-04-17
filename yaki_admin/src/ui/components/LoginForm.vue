<script setup lang="ts">
import buttonPrimary from "@/ui/components/buttons/ButtonPrimary.vue";
import inputText from "@/ui/components/inputs/InputText.vue";
import inputPassword from "@/ui/components/inputs/InputPassword.vue";
import { useAuthStore } from "@/stores/authStore";
import { reactive, ref, watch } from "vue";

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

const openYakiWeb = () => {
  const newWindow = window.open("https://yaki.xpeho.fr/ui/#", "_blank");
  if (newWindow) newWindow.opener = null;
};
</script>

<template>
  <section class="logging_form_container">
    <div :class="['logging_from_wrapper', isLoggingError ? 'logging_error' : '']">
      <p class="text_default__title_header">Administration</p>
      <form>
        <input-text
          :labelText="$t('inputs.login')"
          @emittedInput="onInputLogin"
        />

        <input-password
          :labelText="$t('inputs.password')"
          @emittedInput="onInputPassword"
        />

        <div class="loading_relative_container">
          <button-primary
            :text="$t('buttons.login')"
            @click.prevent="login"
            type="submit"
            :is-disabled="isLloggingLoading"
          />
          <div
            v-show="isLloggingLoading"
            :class="['loader', isLloggingLoading ? 'loader-animation' : '']"
          ></div>
        </div>

        <p class="text_default__Team_description info_text">
          * {{ $t("loginPage.changePasswordInfo") }} <br />
          {{ $t("loginPage.changePasswordInfo2") }}
          <span @click.prevent="openYakiWeb">{{ $t("loginPage.PWALink") }}</span
          >.
        </p>
      </form>
    </div>
  </section>
</template>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
.logging_form_container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-self: center;

  form {
    display: flex;
    flex-direction: column;
    gap: 1.4rem;
  }
}

.logging_from_wrapper {
  display: flex;
  flex-direction: column;
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

.info_text {
  font-family: $font-sf-compact;
  font-size: 0.85rem;
  font-weight: 400;
  letter-spacing: 0.4px;
  padding-inline-start: 1.2rem;

  span {
    font-weight: 600;
    color: $green-xpeho-color;
    cursor: pointer;
  }
}
</style>
