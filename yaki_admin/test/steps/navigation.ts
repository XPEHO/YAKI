import { Then } from "@cucumber/cucumber";
import { teardown } from "./setup";

// STEPS
Then("I close the application", async () => {
  await teardown();
});
