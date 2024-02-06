/**
 * PathParm to determine which page content to show.
 * When a team is deleted, or when the captain team list is empty
 * Used in router and modalFrameView
 */
export enum TEAMPARAMS {
  deleted = "deleted",
  empty = "empty",
}

/**
 * PathParm to determine which page content to show.
 * Depending of the user role to invit.
 * Currently used in PageContentHeader instanciation
 */
export enum INVITEDROLE {
  teammate = "teammate",
  captain = "captain",
}
