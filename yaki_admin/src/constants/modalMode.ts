/**
 * Regroup the current possible modal mode, which will determin modal content to display and behavior.
 * The mode will be determined as argument of switchModalVisibility function. (see modalState.ts)
 *
 * Current modal mode :
 *
 * - userDelete : Handle teammate deletion
 * - teamCreate : Handle team creation
 * - teamEdit : Handle team name edition
 * - teamDelete : Handle team deletion
 */
export enum MODALMODE {
  userDelete = "userDelete",
  teamCreateCustomer = "teamCreateCustomer",
  teamCreate = "teamCreate",
  teamEdit = "teamEdit",
  teamDelete = "teamDelete",
}
