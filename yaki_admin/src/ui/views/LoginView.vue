<script setup lang="ts">
import LoginForm from "@/ui/components/LoginForm.vue";
import Banner from "@/assets/images/splashscreen.svg";
import LanguageSwitch from "@/ui/components/LanguageSwitch.vue";
</script>

<template>
  <section>
    <article>
      <figure class="banner-figure">
        <img
          class="banner"
          v-bind:src="Banner"
          alt="banner"
        />
      </figure>
    </article>

    <article>
      <login-form />

      <div>
        <p>
          {{ $t("loginPage.by") }}
          <a
            href="https://xpeho.com/"
            target="_blank"
            rel="noopener"
            ><span class="color-xpeho">XPEHO</span></a
          >
        </p>
        <a
          href="https://github.com/XPEHO/YAKI/blob/main/PRIVACY_POLICY.md"
          target="_blank"
          rel="noopener"
          >{{ $t("loginPage.privacyPolicy") }}</a
        >
        <language-switch :version="'login'" />
      </div>
    </article>
  </section>
</template>

<style scoped lang="scss">
section {
  background-color: $background-color-theme-primary;
  display: grid;
  grid-template-columns: 0.6fr 1fr;
  height: 100%;

  article:nth-child(1) {
    background-color: $background-color-theme-secondary;
    display: flex;
    justify-content: center;
    align-items: center;
  }
  article:nth-child(2) {
    display: grid;
    grid-template-rows: 1fr 5rem;

    > div {
      display: flex;
      justify-content: center;
      gap: 4rem;

      p {
        color: #7e7e7e;
        font-family: $font-rubik;
      }
      a {
        color: #7e7e7e;
        text-decoration: none;
        font-family: $font-rubik;
        text-align: center;
        width: 15rem;
      }
      .color-xpeho {
        color: $green-xpeho-color;
        font-weight: 600;
      }
    }
  }
}

.banner-figure {
  width: 100%;
  img {
    width: 100%;
    object-fit: contain;
  }
}
</style>
