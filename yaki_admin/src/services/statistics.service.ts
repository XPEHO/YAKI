import { environmentVar } from "@/envPlaceholder";
import { authHeader } from "@/utils/authUtils";

const URL: string = environmentVar.baseURL;

class StatisticsService {
  getStatisticsCsv = async (id: number): Promise<string> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/statistics/customer/${id}/csv`),
    };
    let response: Blob | null = null;

    await fetch(`${URL}/statistics/customer/${id}/csv`, requestOptions)
      .then(async (res) => {
        console.log("res", res);
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
