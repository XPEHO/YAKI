import {test, it, expect} from "vitest";
import {isTeamSelected} from "../../../../src/features/captain/services/isActiveTeam.ts";

test("isTeamSelected", () => {
  test("isSameIndex", () => {
    it("should return true if the given team ID is the same as the selected team ID", () => {
      // Arrange
      isTeamSelected.id = 343;
      const teamId = 343;

      // Act
      const result = isTeamSelected.isSameIndex(teamId);

      // Assert
      expect(result).toBe(true);
    });

    it("should return false if the given team ID is different from the selected team ID", () => {
      // Arrange
      isTeamSelected.id = 1;
      const teamId = 343;

      // Act
      const result = isTeamSelected.isSameIndex(teamId);

      // Assert
      expect(result).toBe(false);
    });
  });
});
