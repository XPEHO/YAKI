import { Given, When, Then } from "@cucumber/cucumber";
import { expect } from "@playwright/test";
import { setup, page } from "./setup";

// COMPOSED STEPS
Given("I launch the application and login as a {string}", async (role: string) => {
  await setup();
  await page.goto("http://localhost:5173/", {
    waitUntil: "networkidle",
  });
  await page.waitForLoadState("load");
  await page.getByLabel("Login").click();
  const login = role === "customer" ? "lazard" : "lavigne";
  await page.getByLabel("Login").fill(login);
  await page.getByLabel("Password").click();
  await page.getByLabel("Password").fill(login);
  await page.getByRole("button", { name: "Login" }).click();
  await page.waitForSelector('button:has-text("Login")', { state: "detached" });
  await expect(page).toHaveURL(/dashboard/);
});

// STEPS
Given("I launch the application", async () => {
  await setup();
  await page.goto("http://localhost:5173/", {
    waitUntil: "networkidle",
  });
  await page.waitForLoadState("load");
});

When("I enter the login as {string}", async (login: string) => {
  await page.getByLabel("Login").click();
  await page.getByLabel("Login").fill(login);
});

When("I enter the password as {string}", async (password: string) => {
  await page.getByLabel("Password").click();
  await page.getByLabel("Password").fill(password);
});

When("I click on login button", async () => {
  await page.getByRole("button", { name: "Login" }).click();
  await page.waitForSelector('button:has-text("Login")', { state: "detached" });
});

Then("I should be redirected to the dashboard", async () => {
  await expect(page).toHaveURL(/dashboard/);
});
