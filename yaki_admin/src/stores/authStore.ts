import {defineStore} from "pinia";
import {loginService} from "@/services/login.service";
import { UserWithIdType } from "@/models/userWithId.type";
import { AuthenticateType } from "@/models/authenticate.type";
import { usersService } from "@/services/users.service";
import { captainService } from "@/services/captain.service";
import { CaptainType } from "@/models/captain.type";

export const useLoginStore = defineStore("loginStore", {
  state: () => ({
    captains: [] as CaptainType[],
    user: {} as UserWithIdType,
    token : '' as string
  }),
  /*getters: {
    getCurrentTeam(): number {
      return this.team;
    },
    getTeammateList(): TeamMateType[] {
      return this.teammate;
    },
  },*/
  actions: {
    async Login(login: string,password: string):Promise<boolean> {
        
        
        try{
            let userResponse : AuthenticateType = await loginService.login(login,password);
            this.token = userResponse.token
            this.user = await usersService.getUserById(userResponse.user_id)
            this.captains = await captainService.getAllCaptainByUserId(this.user.id)
            return true;
        }
      catch{
        return false
      }
      
    },

    async addUserToTeam(userId: number) {
      const data = {teamId: this.team, userId: userId};
      await teamMateService.createTeammate(data);
    },
  },
});