import { Then } from "@cucumber/cucumber";
import { expect } from "@playwright/test";
import { page } from "./setup";

// Path
Then("I should be on {string} path", async (path: string) => {
  const urlRegex = new RegExp(`${path}`);
  await expect(page).toHaveURL(urlRegex);
});

// Sidebar buttons
const isButtonInSidebar = async (text: string) => {
  const sidebarElements = await page.$$(
    ".sidebar__container .text-icon__container:not(.dropdown__container)",
  );
  let found = false;

  for (const element of sidebarElements) {
    const elementText = await element.innerText();
    if (elementText === text) {
      found = true;
      break;
    }
  }

  return found;
};

Then("I should see the button {string} in the sidebar", async (text: string) => {
  const buttonIsInSidebar = await isButtonInSidebar(text);
  expect(buttonIsInSidebar).toBe(true);
});

Then("I should not see the button {string} in the sidebar", async (text: string) => {
  const buttonIsInSidebar = await isButtonInSidebar(text);
  expect(buttonIsInSidebar).toBe(false);
});
