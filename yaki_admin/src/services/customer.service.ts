import { authHeader } from "@/utils/authUtils";
import { handleResponse } from "@/utils/responseUtils";
import { CustomerType } from "@/models/customer.type";
import { environmentVar } from "@/envPlaceholder";

const URL: string = environmentVar.baseURL;

export class CustomerService {
  getAllCustomersRightByUserId = async (userId: number): Promise<CustomerType[]> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/customers/rights/${userId}`),
    };
    const response = await fetch(`${URL}/customers/rights/${userId}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };

  // create a customer
  createCustomer = async (data: CustomerType): Promise<CustomerType> => {
    const requestOptions = {
      method: "POST",
      body: JSON.stringify(data),
      headers: authHeader(`${URL}/customers/create`),
    };
    const response = await fetch(`${URL}/customers/create`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response || data;
  };

  //delete a customer
  deleteCustomer = async (customerId: number): Promise<void> => {
    const requestOptions = {
      method: "DELETE",
      headers: authHeader(`${URL}/customers/delete/${customerId}`),
    };
    await fetch(`${URL}/customers/delete/${customerId}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));
  };

  //add a customer right
  addCustomerRights = async (customerId: number, userId: number): Promise<CustomerType> => {
    const requestOptions = {
      method: "POST",
      body: JSON.stringify({ customerId: customerId, usersId: [userId] }),
      headers: authHeader(`${URL}/customers/addCustomerRights`),
    };
    const response = await fetch(`${URL}/customers/addCustomerRights`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));
    return response;
  };
  getAllUsersRightByCustomerId = async (customerId: number): Promise<number[]> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/customers/usersRights/${customerId}`),
    };
    const response = await fetch(`${URL}/customers/usersRights/${customerId}`, requestOptions)
      .then(handleResponse)
      .catch((err) => console.warn(err));

    return response;
  };
}

export const customerService = Object.freeze(new CustomerService());
