import { Given, When } from "@cucumber/cucumber";
import { setup, page, loginAs } from "./setup";

// Login as a certain role
Given("I launch the application and login as a {string}", async (role: string) => {
  await setup();
  const login = role === "customer" ? "lazard" : "lavigne";
  await loginAs(login);
});

// Launch the application
Given("I launch the application", async () => {
  await setup();
  await page.goto("http://localhost:5173/", {
    waitUntil: "networkidle",
  });
  await page.waitForLoadState("load");
});

// Enter login as a certain user
When("I enter the login as {string}", async (login: string) => {
  await page.getByLabel("Login").click();
  await page.getByLabel("Login").fill(login);
});

// Enter password as a certain user
When("I enter the password as {string}", async (password: string) => {
  await page.getByLabel("Password").click();
  await page.getByLabel("Password").fill(password);
});

// Click on login button
When("I click on login button", async () => {
  await page.getByRole("button", { name: "Login" }).click();
  await page.waitForSelector('button:has-text("Login")', { state: "detached" });
});
