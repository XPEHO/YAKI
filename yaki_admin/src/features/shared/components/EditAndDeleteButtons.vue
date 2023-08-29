<script setup lang="ts">
import editIcon from "@/assets/images/Edit_2.png";
import editAltIcon from "@/assets/images/edit-alt.png";
import deleteIcon from "@/assets/images/Delete_2.png";
import validateIcon from "@/assets/images/check-circle.png";

import {ref} from "vue";

const isEdit = ref(false);

const emit = defineEmits(["accept", "edit", "delete"]);

const props = defineProps({
  useAcceptButton: {
    type: Boolean,
    default: false,
    required: true,
  },
});

const onClickAccept = () => {
  emit("accept");
  isEdit.value = !isEdit.value;
};

const onClickEdit = () => {
  emit("edit");
  isEdit.value = !isEdit.value;
};

const onClickDelete = () => {
  emit("delete");
};

const isAcceptButtonDisplayed = () => {
  return isEdit.value === true && props.useAcceptButton === true;
};
</script>

<template>
  <section class="edit-delete-wrapper">
    <button
      v-show="isAcceptButtonDisplayed()"
      @click.prevent="onClickAccept">
      <figure :class="isAcceptButtonDisplayed() ? 'user-icon-edit' : 'user-icon-default'">
        <img
          v-bind:src="validateIcon"
          alt="" />
      </figure>
    </button>
    <button @click.prevent="onClickEdit">
      <figure :class="isAcceptButtonDisplayed() ? 'user-icon-edit' : 'user-icon-default'">
        <img
          v-bind:src="isAcceptButtonDisplayed() ? editAltIcon : editIcon"
          alt="" />
      </figure>
    </button>
    <button @click.prevent="onClickDelete">
      <figure class="user-icon-default">
        <img
          v-bind:src="deleteIcon"
          alt="" />
      </figure>
    </button>
  </section>
</template>

<style scoped lang="scss">
.edit-delete-wrapper {
  display: flex;
  align-items: center;
  gap: 2rem;

  button {
    border: none;
    background-color: transparent;

    &:active {
      transform: scale(0.95);
    }
  }
}

.user-icon-default {
  width: 1.4rem;
  img {
    width: 100%;
    object-fit: contain;
  }
}

.user-icon-edit {
  width: 2rem;
  img {
    width: 100%;
    object-fit: contain;
    filter: drop-shadow(2px 4px 2px rgba(0, 0, 0, 0.209));
  }
}
</style>
