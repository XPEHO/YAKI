import { useAuthStore } from '@/stores/authStore';
import {environmentVar} from "@/envPlaceholder";

export function authHeader(url:string) {
  // Return auth header with JWT if the user is logged in and the request is to the API URL
  const { user } = useAuthStore();
  const isLoggedIn = !!user?.token;
  const isApiUrl = url.startsWith(environmentVar.baseURL);
  if (isLoggedIn && isApiUrl && user.token != null) {
    return { 
      'Authorization': `Bearer ${user.token}`,
      "Content-Type": "application/json",
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Authorization, Cache-Control',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, DELETE',
     };
  } else {
    return {
      'Authorization': '',
      "Content-Type": "application/json",
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Headers': 'Authorization, Cache-Control',
      'Access-Control-Allow-Methods': 'GET, POST, OPTIONS, PUT, DELETE',};
  }
}