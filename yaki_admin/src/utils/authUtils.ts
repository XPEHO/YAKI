import { useAuthStore } from '@/stores/authStore';

export function authHeader(url:string) {
  // Return auth header with JWT if the user is logged in and the request is to the API URL
  const { user } = useAuthStore();
  const isLoggedIn = !!user?.token;
  const isApiUrl = url.startsWith(import.meta.env.VITE_API_URL);
    
  if (isLoggedIn && isApiUrl && user.token != null) {
    return { 
        'Content-Type': 'application/json',
        Authorization: `Bearer ${user.token}` };
  } else {
    return {
        'Content-Type': 'application/json',
        Authorization: ''};
  }
}