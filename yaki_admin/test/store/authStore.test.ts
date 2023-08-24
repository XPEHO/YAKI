import { describe,it,expect,test, vi, beforeEach } from 'vitest';
import  {useAuthStore} from '../../src/stores/authStore'; // Update the path to match your component's location
import { setActivePinia, createPinia } from 'pinia'
import {loginService} from '../../src/services/login.service';

//mock the login service
vi.mock('../../src/services/login.service', () => {
    return {
        login: {
            user: {
                user_id: 1,
                token: "token",
            },
            customerId: [],
            captainId: [1],
        },
    }
})

describe('Authentication Store', () => {
    beforeEach(() => {
      // creates a fresh pinia and make it active so it's automatically picked
      // up by any useStore() call without having to pass it to it:
      // `useStore(pinia)`
      setActivePinia(createPinia())
    })
    test('should login as a captain', async () => {
        const authStore = useAuthStore();
        const user = await authStore.login('captain', 'password');
        //expect(login).toHaveBeenCalledOnce();
        expect(user).toBe(true);

    // 
        });

});
