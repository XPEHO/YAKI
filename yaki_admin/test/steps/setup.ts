import { chromium, Browser, Page } from "@playwright/test";

let browser: Browser;
let page: Page;

const setup = async () => {
  browser = await chromium.launch({ headless: process.env.CI === "true" });
  const context = await browser.newContext({
    locale: "en-US",
    extraHTTPHeaders: {
      "Accept-Language": "en-US,en;q=0.9",
    },
  });
  page = await context.newPage();
};

const teardown = async () => {
  if (browser) {
    await browser.close();
  }
};

export { setup, page, teardown };
