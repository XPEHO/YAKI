<script setup lang="ts">
import PageContentHeader from "@/ui/components/PageContentHeader.vue";
import PageContentLayout from "@/ui/layouts/PageContentLayout.vue";
import buttonPrimary from "@/ui/components/buttons/ButtonPrimary.vue";
import InputDropdown from "@yaki_ui/yaki_ui_web_components/components/vue/InputDropdown.vue";
import PreviewTable from "@yaki_ui/yaki_ui_web_components/components/vue/PreviewTable.vue";

import { statisticsService } from "@/services/statistics.service";
import { useSelectedRoleStore } from "@/stores/selectedRole";

import { useTeamStore } from "@/stores/teamStore";
import { onMounted, ref, reactive } from "vue";
import { useRoleStore } from "@/stores/roleStore";
import { TeamType } from "@/models/team.type";
import { STATISTICTYPE } from "@/constants/statisticType.enum";
import { useI18n } from "vue-i18n";
import { textDirection } from "@/models/dataTable.type";

const i18n = useI18n();

const selectedRoleStore = useSelectedRoleStore();
const roleStore = useRoleStore();
const teamStore = useTeamStore();

const statsticsTypeArray: Array<string> = Object.entries(STATISTICTYPE).map((x) =>
  x[1].toString().split("-").join(" "),
);

const statisticsForm = reactive({
  statisticTypeSelected: statsticsTypeArray[0] as STATISTICTYPE,
  teamSelected: 0,
});

const teamList = ref<TeamType[]>([]);
const fullTeamList = ref<TeamType[]>([]);

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

  const teamListWithDefault = [...teamList.value];
  teamListWithDefault.unshift({
    id: 0,
    teamName: i18n.t("statistics.allTeamsOption"),
    customerId: 0,
    teamDescription: "",
    captainsId: [],
    captains: [],
  });
  fullTeamList.value = teamListWithDefault;

  loadPreview();
});

const downloadCsv = async () => {
  const customerId = selectedRoleStore.getCustomerIdSelected;

  try {
    const link = document.createElement("a");
    const url = await statisticsService.getStatisticsCsv(
      customerId,
      statisticsForm.teamSelected,
      statisticsForm.statisticTypeSelected,
      periodStartSelected.value,
      periodEndSelected.value,
    );
    link.href = url;
    link.download = `statistics_${
      STATISTICTYPE[statisticsForm.statisticTypeSelected as keyof typeof STATISTICTYPE]
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
      statisticsForm.teamSelected,
      statisticsForm.statisticTypeSelected,
      periodStartSelected.value,
      periodEndSelected.value,
    );
  } catch (error) {
    console.error("Error while getting preview :", error);
  }
};

const onStatisticTypeSelect = (value: any) => {
  statisticsForm.statisticTypeSelected = value as STATISTICTYPE;
  loadPreview();
};

const onTeamSelect = (value: any) => {
  statisticsForm.teamSelected = Number(value);
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
          <input-dropdown
            :labelText="$t('statistics.statisticTypeSelectorLabel')"
            :placeHolderValue="statsticsTypeArray[0]"
            :valueGroup="statsticsTypeArray"
            :selectedValue="statsticsTypeArray[0]"
            @emittedSelectedInput="onStatisticTypeSelect"
          />

          <input-dropdown
            v-if="fullTeamList.length > 0"
            :labelText="$t('statistics.teamSelectorLabel')"
            :placeHolderValue="fullTeamList[0].id.toString()"
            :valueNames="fullTeamList.map((team) => team.teamName)"
            :valueGroup="fullTeamList.map((team) => team.id.toString())"
            :selectedValue="fullTeamList[0].id.toString()"
            @emittedSelectedInput="onTeamSelect"
          />

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
          <PreviewTable
            :statisticsArray="statisticsPreview"
            :rows-per-page="10"
            :text-align-headers="[textDirection.center]"
            :text-align-content="[textDirection.left]"
            :is-page-change-enabled="true"
          />
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
