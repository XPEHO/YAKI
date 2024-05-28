<script setup lang="ts">
import { computed, ref } from "vue";
import chevronLeftIcon from "@/assets/icons_svg/Chevron-left.svg";
import chevronRightIcon from "@/assets/icons_svg/Chevron-right.svg";

//define the props
const props = defineProps({
  statisticsArray: {
    type: Array<Array<string>>,
    required: true,
  },
});

// Pagination variables
const currentPage = ref(1);
const rowsPerPage = 10;

// Computed property for pagination
const paginatedStatisticsArray = computed(() => {
  // We get the start using the currentPage and rowsPerPage and we add 1 to ignore the first row (headers)
  let start = 1 + (currentPage.value - 1) * rowsPerPage;
  // We get the end using the start and rowsPerPage
  let end = start + rowsPerPage;
  // We filter the array to remove empty rows
  return props.statisticsArray.slice(start, end).filter((row) => row[0] !== "" || row.length > 1);
});

// Methods for pagination
const nextPage = () => {
  if (currentPage.value * rowsPerPage < props.statisticsArray.length) {
    currentPage.value++;
  }
};

const prevPage = () => {
  if (currentPage.value > 1) {
    currentPage.value--;
  }
};
</script>

<template>
  <table v-if="paginatedStatisticsArray.length && paginatedStatisticsArray[0][0] !== ''">
    <thead>
      <tr>
        <th
          v-for="header in props.statisticsArray[0]"
          :key="header"
        >
          {{ header }}
        </th>
      </tr>
    </thead>
    <tbody>
      <tr
        v-for="(row, index) in paginatedStatisticsArray"
        :key="index"
      >
        <td
          v-for="(cell, index) in row"
          :key="index"
        >
          {{ cell }}
        </td>
      </tr>
      <!-- We fill the table with empty cells to always have the same size-->
      <tr
        v-for="index in rowsPerPage - paginatedStatisticsArray.length"
        :key="index"
      >
        <td
          v-for="index in props.statisticsArray[0].length"
          :key="index"
          style="opacity: 0"
        >
          ''
        </td>
      </tr>
    </tbody>
  </table>
  <section v-if="paginatedStatisticsArray.length && paginatedStatisticsArray[0][0] !== ''">
    <button
      @click="prevPage"
      :style="currentPage === 1 ? 'pointer-events: none; opacity: 0.2;' : ''"
    >
      <figure>
        <img
          :src="chevronLeftIcon"
          alt=""
        />
      </figure>
    </button>
    <span
      >Page : {{ currentPage }} / {{ Math.ceil((statisticsArray.length - 1) / rowsPerPage) }}</span
    >
    <button
      @click="nextPage"
      :style="
        currentPage * rowsPerPage >= statisticsArray.length
          ? 'pointer-events: none; opacity: 0.2;'
          : ''
      "
    >
      <figure>
        <img
          :src="chevronRightIcon"
          alt=""
        />
      </figure>
    </button>
  </section>
</template>

<style scoped lang="scss">
table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 20px;
  font-family: $font-sf-compact;
  font-size: 11pt;

  th,
  td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
  }

  tr {
    background-color: white;

    &:nth-child(even) {
      background-color: #f2f2f2;
    }
  }

  th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    background-color: $background-color-theme-secondary;
  }
}

section {
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 1rem;
  font-family: $font-rubik;

  button {
    border: none;
    background-color: $background-color-theme-primary;
    cursor: pointer;
  }
}
</style>
