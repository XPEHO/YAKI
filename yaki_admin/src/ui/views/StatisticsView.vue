<script setup lang="ts">
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import buttonPrimary from "@/ui/components/buttons/ButtonPrimary.vue";
import PreviewTable from "@/ui/components/PreviewTable.vue";

import { statisticsService } from "@/services/statistics.service";
import { useSelectedRoleStore } from "@/stores/selectedRole";

import { useTeamStore } from "@/stores/teamStore";
import { onMounted, ref } from "vue";
import { useRoleStore } from "@/stores/roleStore";
import { TeamType } from "@/models/team.type";
import { STATISTICTYPE } from "@/constants/statisticType.enum";

const selectedRoleStore = useSelectedRoleStore();
const roleStore = useRoleStore();
const teamStore = useTeamStore();

const teamList = ref<TeamType[]>([]);
const teamSelected = ref<number>(0);
const statisticTypeSelected = ref<STATISTICTYPE>(STATISTICTYPE.basic);
// Set the default value to 30 days before the current date and the current date in format yyyy-mm-dd
const periodStartSelected = ref<string>(
  new Date(Date.now() - 30 * 24 * 60 * 60 * 1000).toISOString().split("T")[0],
);
const periodEndSelected = ref<string>(new Date().toISOString().split("T")[0]);
const statisticsPreview = ref<Array<Array<string>>>([[""]]);

onMounted(() => {
  if (roleStore.getCustomersIdWhereIgotRights.length === 0) {
    // If the user is a captain
    teamList.value = teamStore.getTeamListByCaptain;
  } else {
    // If the user is a customer
    teamStore.setTeamsListByCustomerId(selectedRoleStore.getCustomerIdSelected);

    // Retrieve and assign all the teams owned by the captains under the customer
    for (let team of teamStore.getTeamListByCustomer) {
      teamList.value.push(team);
    }
  }
});

const downloadCsv = async () => {
  const customerId = selectedRoleStore.getCustomerIdSelected;

  try {
    const link = document.createElement("a");
    const url = await statisticsService.getStatisticsCsv(
      customerId,
      teamSelected.value,
      statisticTypeSelected.value,
      periodStartSelected.value,
      periodEndSelected.value,
    );
    link.href = url;
    link.download = `statistics_${
      STATISTICTYPE[statisticTypeSelected.value as keyof typeof STATISTICTYPE]
    }.csv`;
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  } catch (error) {
    console.error("Error while getting CSV :", error);
  }
};

const loadPreview = async () => {
  const customerId = selectedRoleStore.getCustomerIdSelected;
  try {
    statisticsPreview.value = await statisticsService.getStatisticsArray(
      customerId,
      teamSelected.value,
      statisticTypeSelected.value,
      periodStartSelected.value,
      periodEndSelected.value,
    );
  } catch (error) {
    console.error("Error while getting preview :", error);
  }
};

const onSelectTeam = (e: Event) => {
  teamSelected.value = parseInt((e.target as HTMLSelectElement).value);
  loadPreview();
};

const onSelectStatisticType = (e: Event) => {
  statisticTypeSelected.value = (e.target as HTMLSelectElement).value as STATISTICTYPE;
  loadPreview();
};

const onSelectPeriodStart = (e: Event) => {
  periodStartSelected.value = (e.target as HTMLInputElement).value;
  if (new Date((e.target as HTMLInputElement).value) > new Date(periodEndSelected.value)) {
    periodEndSelected.value = (e.target as HTMLInputElement).value;
  }
  loadPreview();
};

const onSelectPeriodEnd = (e: Event) => {
  periodEndSelected.value = (e.target as HTMLInputElement).value;
  if (new Date((e.target as HTMLInputElement).value) < new Date(periodStartSelected.value)) {
    periodStartSelected.value = (e.target as HTMLInputElement).value;
  }
  loadPreview();
};
</script>

<template>
  <page-content-layout>
    <template #pageContentHeader>
      <page-content-header :title="$t('sidebar.statistics')" />
    </template>
    <template #content>
      <main>
        <section>
          <article class="statistic-selector-container">
            <label
              for="statisticTypeSelected"
              class="text_default__Team_name"
              >{{ $t("statistics.statisticTypeSelectorLabel") }}</label
            >
            <select
              class="statistic-selector"
              name="statisticTypeSelected"
              @change="onSelectStatisticType"
            >
              <option
                :key="statKey"
                :value="statKey"
                v-for="[statKey, statValue] in Object.entries(STATISTICTYPE)"
                :selected="statValue == statisticTypeSelected"
              >
                {{ $t("statistics." + statKey) }}
              </option>
            </select>
          </article>
          <article class="statistic-selector-container">
            <label
              class="text_default__Team_name"
              for="teamSelected"
              >{{ $t("statistics.teamSelectorLabel") }}</label
            >
            <select
              class="statistic-selector"
              name="teamSelected"
              @change="onSelectTeam"
            >
              <option
                value="0"
                selected
              >
                {{ $t("statistics.allTeamsOption") }}
              </option>
              <option
                :key="team.id"
                :value="team.id"
                v-for="team in teamList"
              >
                {{ team.teamName }}
              </option>
            </select>
          </article>
          <article>
            <div class="date-selector-container">
              <label
                class="text_default__Team_name"
                for="dateSelected"
                >{{ $t("statistics.dateSelectorStartLabel") }}</label
              >
              <input
                type="date"
                class="date-selector"
                :value="periodStartSelected"
                @change="onSelectPeriodStart"
              />
            </div>
            <div class="date-selector-container">
              <label
                class="text_default__Team_name"
                for="dateSelected"
                >{{ $t("statistics.dateSelectorEndLabel") }}</label
              >
              <input
                type="date"
                class="date-selector"
                :value="periodEndSelected"
                @change="onSelectPeriodEnd"
              />
            </div>
          </article>
        </section>
        <section>
          <buttonPrimary
            :text="$t('buttons.downloadCsv')"
            @click.prevent="downloadCsv"
          />
        </section>
        <section>
          <PreviewTable :statisticsArray="statisticsPreview" />
        </section>
      </main>
    </template>
  </page-content-layout>
</template>

<style scoped>
main {
  display: flex;
  flex-direction: column;
  padding: 2rem;
  align-items: center;
}

section {
  padding: 1rem;
  display: flex;
  flex-flow: column nowrap;
  align-items: flex-start;
  gap: 2rem;

  & button {
    width: 20rem;
  }

  & article {
    display: flex;
    flex-flow: row nowrap;
    align-items: center;
    gap: 1rem;

    &.statistic-selector-container {
      & .statistic-selector {
        height: 2rem;
        padding: 0.2rem 0.5rem;
        border-color: #7d818c;
        background-color: #f2f6f9;
        border-radius: 5px;
        font-family: "Rubik", sans-serif;

        & option {
          background-color: #f2f6f9;
          color: #7d818c /*#ff936b*/;
        }

        &:focus {
          outline: none;
        }
      }
    }

    & .date-selector-container {
      display: flex;
      flex-flow: row nowrap;
      align-items: center;
      gap: 1rem;

      & .date-selector {
        height: 2rem;
        padding: 0.2rem 0.5rem;
        border: 1px solid #7d818c;
        background-color: #f2f6f9;
        border-radius: 5px;
        font-family: "Rubik", sans-serif;

        &:focus {
          outline: none;
        }
      }
    }
  }
}
</style>
