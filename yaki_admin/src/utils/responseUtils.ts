import { useAuthStore } from "@/stores/authStore";
export function handleResponse(response: globalThis.Response): Promise<any> {
  return response.text().then((text) => {
    const data = text && JSON.parse(text);

    if (!response.ok) {
      const { user, logout } = useAuthStore();
      if ([401, 403].includes(response.status) && user) {
        // Auto logout if 401 Unauthorized or 403 Forbidden response is returned from the API
        logout();
      }

      const error = (data && data.message) || response.statusText;
      return Promise.reject(error);
    }

    return data;
  });
}
