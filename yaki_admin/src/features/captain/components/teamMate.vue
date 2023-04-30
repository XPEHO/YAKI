<template>
    <div>
      <p class="name">{{ teamMate.firstName }} {{ teamMate.lastName }}</p>
      <p class="email">{{ teamMate.email }}</p>
    </div>
  </template>
  
  <script lang="ts">
  import { defineComponent } from 'vue';
  import type { TeamMateType } from '../../../services/teamMate.type';
  
  export default defineComponent({
    name: 'TeamMate',
    props: {
      // The prop 'teamMate' is of type 'TeamMateType' and is required.
      teamMate: {
        type: Object as () => TeamMateType,
        required: true,
      },
    },
  });
  </script>