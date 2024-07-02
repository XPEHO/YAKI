<script setup lang="ts">
import buttonIcon from "@/ui/components/buttons/ButtonIcon.vue";
import eyeIcon from "@/assets/icons_svg/Eye.svg";
import { PropType, onBeforeMount, ref } from "vue";
import { TeamType } from "@/models/team.type";
import { TeamLogoType } from "@/models/TeamLogo.type";
import { teamLogoService } from "@/services/teamLogo.service";
import { setTeamLogoUrl } from "@/utils/images.utils";
import { useLanguageStore } from "@/stores/languageStore";
import router from "@/router/router";

const languageStore = useLanguageStore();

const teamLogo = ref<TeamLogoType>({
  teamId: 0,
  teamLogoBlob: null,
});

//define the props
const props = defineProps({
  team: {
    type: Object as PropType<TeamType>,
    required: true,
  },
});

//before mount, set logo of the team
onBeforeMount(async () => {
  teamLogo.value = await getTeamLogo(props.team.id);
});

//define the computed
const getTeamLogo = async (teamId: number) => {
  const teamLogo: TeamLogoType = await teamLogoService.getTeamLogo(teamId);
  return teamLogo;
};

//define the methods
const onSeeDetailPress = () => {
  router.push({ path: `team-details/${props.team.id}` });
};
</script>

<template>
  <article class="user-card__container user-card__accepted_status">
    <figure class="user-card__avatar rounded">
      <div>
        <img
          class="user-card__avatar-img"
          :src="setTeamLogoUrl(teamLogo!.teamLogoBlob)"
          alt="user-card"
        />
      </div>
    </figure>

    <div class="user-card__wrapper-user-infos">
      <p class="user-card__name-text">{{ team.teamName }}</p>
      <p
        v-if="props.team.lastActivity"
        class="user-card__info-text"
      >
        {{ $t("teamStatus.lastActivity")
        }}{{
          props.team.lastActivity && languageStore.getLanguage !== null
            ? `${new Date(props.team.lastActivity).toLocaleDateString(
                languageStore.getLanguage,
              )} - ${new Date(props.team.lastActivity).toLocaleTimeString(
                languageStore.getLanguage,
              )}`
            : "No latest activity so far"
        }}
      </p>
    </div>
    <section class="user-card__wrapper-status">
      <div class="user-card__wrapper-status_buttons">
        <button-icon
          @click.prevent="onSeeDetailPress"
          :icon="eyeIcon"
          :alt="$t('buttons.seeDetail')"
        />
      </div>
    </section>
  </article>
</template>
