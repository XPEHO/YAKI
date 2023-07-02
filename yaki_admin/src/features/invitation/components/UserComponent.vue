<script setup lang="ts">
import avatarIcon from "@/assets/avatar.png";
import YakiButton from "@/features/shared/components/YakiButton.vue";
</script>

<template>
  <section class="user-component__card">
    <div>
      <article class="card__img-identity">
        <figure>
          <img
            v-bind:src="avatarIcon"
            alt="Image de profil" />
        </figure>
        <article>
          <p>Nom prénom</p>
          <p>Email</p>
        </article>
      </article>

      <yaki-button
        text="INVITE"
        css-class="button-class-test" />
    </div>
  </section>
</template>

<style lang="scss">
.user-component__card {
  display: flex;
  justify-content: space-around;
  align-items: center;

  width: 100%;

  background-color: #d9d9d9;

  div {
    display: flex;
    align-items: center;
    width: 90%;

    padding-block: 0.3rem;

    .card__img-identity {
      display: flex;
      gap: 2rem;
      flex-grow: 3;

      article {
        p:nth-child(1) {
          font-size: 1.5rem;
          font-family: Inter;
          font-weight: 900;
        }
      }
    }

    figure {
      width: 4rem;
      img {
        user-select: none;
        width: 100%;
        object-fit: cover;
      }
    }

    .button-class-test {
      flex-grow: 2;

      border: none;
      border-radius: 5rem;
      background-color: #bad26e;
      height: 90%;

      padding-block: 1rem;

      color: #000;
      font-size: 1rem;
      font-family: Inter;
      font-weight: 900;

      &:active {
        transform: scale(0.97);
      }
    }
  }
}
</style>
