<script setup lang="ts">
import {registerService} from "@/services/register.service";
import {onBeforeMount, ref} from "vue";
import errorIcon from "@/assets/images/error-404.png";

const message = ref("");
const props = defineProps({
  token: {
    type: String,
    required: true,
  },
});
onBeforeMount(async () => {
  await getMessage();
});
const getMessage = async () => {
  message.value = await registerService.registerConfirm(props.token);
};
</script>
<template>
  <div class="container-registration-confirmation">
    <figure v-if="message[0] != 'Y'">
      <img v-bind:src="errorIcon" />
    </figure>
    <div class="box-centered">
      <h1 v-if="message[0] == 'Y'">Account created!</h1>
      <p class="verbose">{{ message }}</p>
    </div>
  </div>
</template>

<style scoped lang="scss">
.container-registration-confirmation {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 2rem;
  height: 100%;
  background-color: #ff936b;
}
.box-centered {
  background-color: #fff;
  width: 50%;
  height: 10rem;
  border-radius: 30px;
  display: grid;
  place-items: center;
  box-shadow: 3px 3px 3px #786666;
}
h1 {
  font-size: 32px;
  font-family: bold;
  color: black;
}
p {
  font-size: 24px;
  font-family: sans-serif;
  text-align: center;
  color: black;
}
figure {
  width: 15rem;
  img {
    width: 100%;
    object-fit: contain;
  }
}
</style>
