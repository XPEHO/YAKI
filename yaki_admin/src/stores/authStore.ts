import {defineStore} from "pinia";
import {loginService} from "@/services/login.service";
import { captainService } from "@/services/captain.service";
import { CaptainType } from "@/models/captain.type";
import router from "@/router/router";
import {useTeamStore} from "@/stores/teamStore.js";
export const useAuthStore = defineStore("loginStore", {
  state: () => ({
    captains: [] as CaptainType[],
    user: (() => {
      const userString = localStorage.getItem('user');
      return userString ? JSON.parse(userString) : '';
    })(),
    returnedUrl: null as string | null
  }),
  actions: {
    async login(login: string,password: string):Promise<boolean> {
        try{
            this.user = await loginService.login(login,password);
            localStorage.setItem('user', JSON.stringify(this.user));
            this.captains = await captainService.getAllCaptainByUserId(this.user.id)
            //if the user is not a captain he can't access to the admin part
            if(this.captains.length == 0){
              this.logout()
              return false
            }
            let ids = []
            for (const captain of this.captains) {
              ids.push(captain.id);
            }
            const teamStore = useTeamStore();
            teamStore.setCaptainsId(ids)
            router.push(this.returnedUrl || '/administration/captain');
            return true;
        }
      catch{
        return false
      }
      
    },
    logout() {
        this.user = null;
        localStorage.removeItem('user');
        router.push('/');
    }
  },
});