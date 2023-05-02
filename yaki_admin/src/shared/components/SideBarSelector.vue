<script setup lang="ts"></script>

<template>
  <section class="side-bar-selector">
    <div>
      <figure>
        <img
          src="../../assets/Vector.png"
          alt="" />
      </figure>
      <p>My teams</p>
    </div>
  </section>
</template>

<style lang="scss">
.side-bar-selector {
  display: flex;
  justify-content: center;
  gap: 1rem;

  background-color: #59a9b5;

  width: 100%;
  padding-block: 1rem;

  div {
    display: flex;
    align-items: center;
    gap: 1rem;
  }

  figure {
    width: 1.5rem;
    img {
      width: 100%;
    }
  }

  p {
    font-size: 1.2rem;
    letter-spacing: 0.05rem;
    color: rgb(239, 237, 237);
  }
}
</style>
