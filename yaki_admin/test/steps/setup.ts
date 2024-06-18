import { chromium, Browser, Page } from "@playwright/test";
import { setDefaultTimeout } from "@cucumber/cucumber";

let browser: Browser;
let page: Page;

setDefaultTimeout(10000); // Timeout set to 10000 milliseconds because login is too long

// Setup function to launch the browser and the page
const setup = async () => {
  browser = await chromium.launch({ headless: process.env.CI === "true" });
  // Create a new browser context with a specific language
  const context = await browser.newContext({
    locale: "en-US",
    extraHTTPHeaders: {
      "Accept-Language": "en-US,en;q=0.9",
    },
  });
  page = await context.newPage();
};

// Teardown function to close the browser
const teardown = async () => {
  if (browser) {
    await browser.close();
  }
};

// Login function to avoid repeating the login steps
const loginAs = async (login: string) => {
  await page.goto("http://localhost:5173/", {
    waitUntil: "networkidle",
  });
  await page.waitForLoadState("load");
  await page.getByLabel("Login").click();
  await page.getByLabel("Login").fill(login);
  await page.getByLabel("Password").click();
  await page.getByLabel("Password").fill(login);
  await page.getByRole("button", { name: "Login" }).click();
  await page.waitForSelector('button:has-text("Login")', { state: "detached" });
};

export { setup, page, teardown, loginAs };
