import {test, it, expect} from "vitest";
import isSelectedTeamActive from "../../../../src/features/shared/services/isSelectedTeamActive";

test("isSelectedTeamActive", () => {
  test("isSameIndex", () => {
    it("should return true if the given team ID is the same as the selected team ID", () => {
      // Arrange
      isSelectedTeamActive.id = 1;
      const teamId = 1;

      // Act
      const result = isSelectedTeamActive.isSameTeamId(teamId);

      // Assert
      expect(result).toBe(true);
    });

    it("should return false if the given team ID is different from the selected team ID", () => {
      // Arrange
      isSelectedTeamActive.id = 1;
      const teamId = 2;

      // Act
      const result = isSelectedTeamActive.isSameTeamId(teamId);

      // Assert
      expect(result).toBe(false);
    });
  });
});
