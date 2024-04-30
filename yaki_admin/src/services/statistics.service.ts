import { STATISTICTYPE } from "@/constants/statisticType.enum";
import { environmentVar } from "@/envPlaceholder";
import { authHeader } from "@/utils/authUtils";

const URL: string = environmentVar.baseURL;

class StatisticsService {
  getStatisticsCsv = async (
    customerId: number,
    teamId: number,
    statisticType: STATISTICTYPE,
    periodStart: string,
    periodEnd: string,
  ): Promise<string> => {
    const requestOptions = {
      method: "POST",
      headers: authHeader(
        `${URL}/statistics/${STATISTICTYPE[statisticType as keyof typeof STATISTICTYPE]}/csv`,
      ),
      body: JSON.stringify({
        customerId: customerId,
        teamId: teamId,
        periodStart: periodStart,
        periodEnd: periodEnd,
      }),
    };
    let response: Blob | null = null;

    await fetch(
      `${URL}/statistics/${STATISTICTYPE[statisticType as keyof typeof STATISTICTYPE]}/csv`,
      requestOptions,
    )
      .then(async (res) => {
        response = await res.blob();
      })
      .catch((err) => {
        console.warn(err);
      });

    if (response) {
      const url = window.URL.createObjectURL(response);
      return url;
    } else {
      return "javascript:void(0)";
    }
  };
}

export const statisticsService = Object.freeze(new StatisticsService());
