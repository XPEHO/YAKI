import { Then, When } from "@cucumber/cucumber";
import { teardown, page } from "./setup";

// STEPS

// Close the application
Then("I close the application", async () => {
  await teardown();
});

// Click on a certain text
When("I click on the text {string}", async (text: string) => {
  await page.getByText(text).click();
});

// Sidebar buttons
When("I click on the button {string} in the sidebar", async (text: string) => {
  const sidebarElements = await page.$$(
    ".sidebar__container .text-icon__container:not(.dropdown__container)",
  );

  for (const element of sidebarElements) {
    const elementText = await element.innerText();
    if (elementText === text) {
      await element.click();
      break;
    }
  }
});
