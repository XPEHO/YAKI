import {defineStore} from "pinia";
import {loginService} from "@/services/login.service";
import { captainService } from "@/services/captain.service";
import { CaptainType } from "@/models/captain.type";
import router from "@/router/router";
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
            this.captains = await captainService.getAllCaptainByUserId(this.user.user_id)
            router.push(this.returnedUrl || '/');
            return true;
        }
      catch{
        return false
      }
      
    },
    logout() {
        this.user = null;
        localStorage.removeItem('user');
        router.push('/login');
    }
  },
});