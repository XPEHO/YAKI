export const environmentVar = {
  baseURL: process.env.NODE_ENV === "development" ? "http://localhost:8080" : "URL_PLACEHOLDER",

  tempUserIdRangeStart: 1,
  tempUserIdRAngeEnd: 50,
};
