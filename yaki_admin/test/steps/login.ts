import { Given, When } from "@cucumber/cucumber";
import { setup, page, loginAs } from "./setup";
import dotenv from "dotenv";
dotenv.config();

// Login as a certain role
Given("I launch the application and login as a {string}", async (role: string) => {
  await setup();
  await loginAs(role);
});

// Launch the application
Given("I launch the application", async () => {
  await setup();
  if (!process.env.CUCUMBER_URL_UAT) {
    throw new Error("No url defined");
  }
  await page.goto(process.env.CUCUMBER_URL_UAT, {
    waitUntil: "networkidle",
  });
  await page.waitForLoadState("load");
});

// Enter login as a certain user
When("I enter the login as {string}", async (role: string) => {
  await page.getByLabel("Login").click();
  let login;
  if (role === "captain") {
    login = process.env.CUCUMBER_LOGIN_CAPTAIN ?? "";
  } else if (role === "customer") {
    login = process.env.CUCUMBER_LOGIN_CUSTOMER ?? "";
  } else {
    throw new Error("Unknown role");
  }
  await page.getByLabel("Login").fill(login);
});

// Enter password as a certain user
When("I enter the password as {string}", async (role: string) => {
  await page.getByLabel("Password").click();
  let password;
  if (role === "captain") {
    password = process.env.CUCUMBER_PASSWORD_CAPTAIN ?? "";
  } else if (role === "customer") {
    password = process.env.CUCUMBER_PASSWORD_CUSTOMER ?? "";
  } else {
    throw new Error("Unknown role");
  }
  await page.getByLabel("Password").fill(password);
});

// Click on login button
When("I click on login button", async () => {
  await page.getByRole("button", { name: "Login" }).click();
  await page.waitForSelector('button:has-text("Login")', { state: "detached" });
});
