import { STATISTICTYPE } from "@/constants/statisticType.enum";
import { environmentVar } from "@/envPlaceholder";
import { teamActivity } from "@/stores/statisticsStore";
import { authHeader } from "@/utils/authUtils";
import { handleResponse } from "@/utils/responseUtils";

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

  getStatisticsArray = async (
    customerId: number,
    teamId: number,
    statisticType: STATISTICTYPE,
    periodStart: string,
    periodEnd: string,
  ): Promise<Array<Array<string>>> => {
    const data = await this.getStatisticsCsv(
      customerId,
      teamId,
      statisticType,
      periodStart,
      periodEnd,
    );

    const response = await fetch(data);
    const csvText = await response.text();

    return csvText.split("\n").map((row) => row.split(","));
  };

  getLatestTeamActivityByCustomerId = async (
    customerId?: number,
    teamId?: number,
  ): Promise<teamActivity[]> => {
    const requestOptionsCustomer = {
      method: "GET",
      headers: authHeader(`${URL}/statistics/lastActivity?customerId=${customerId}`),
    };

    const requestOptionsTeam = {
      method: "GET",
      headers: authHeader(`${URL}/statistics/lastActivity?teamId=${teamId}`),
    };

    if (customerId) {
      const response = await fetch(
        `${URL}/statistics/lastActivity?customerId=${customerId}`,
        requestOptionsCustomer,
      )
        .then(handleResponse)
        .catch((err) => console.warn(err));
      return response;
    } else if (teamId) {
      const response = await fetch(
        `${URL}/statistics/lastActivity?teamId=${teamId}`,
        requestOptionsTeam,
      )
        .then(handleResponse)
        .catch((err) => console.warn(err));
      return response;
    } else {
      return [];
    }
  };
}

export const statisticsService = Object.freeze(new StatisticsService());
