import {test, it, expect} from "vitest";
import {isTeamSelected} from "../../../../src/features/shared/services/isActiveTeam.ts";

test("isTeamSelected", () => {
  test("isSameIndex", () => {
    it("should return true if the given team ID is the same as the selected team ID", () => {
      // Arrange
      isTeamSelected.id = 1;
      const teamId = 1;

      // Act
      const result = isTeamSelected.isSameTeamId(teamId);

      // Assert
      expect(result).toBe(true);
    });

    it("should return false if the given team ID is different from the selected team ID", () => {
      // Arrange
      isTeamSelected.id = 1;
      const teamId = 2;

      // Act
      const result = isTeamSelected.isSameTeamId(teamId);

      // Assert
      expect(result).toBe(false);
    });
  });
});
