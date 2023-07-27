import { authHeader } from "@/utils/authUtils";
import { handleResponse } from "@/utils/responseUtils";
import { CustomerType } from "@/models/customer.type";
import { CustomersRightsType } from "@/models/customersRights.type";
import { environmentVar } from "@/envPlaceholder";

const URL: string = environmentVar.baseURL;

export class CustomerService {
  getAllCustomersRightById = async (
    userId: number
  ): Promise<CustomersRightsType[]> => {
    const requestOptions = {
      method: "GET",
      headers: authHeader(`${URL}/customers/rights/${userId}`),
    };
    const response = await fetch(
      `${URL}/customers/rights/${userId}`,
      requestOptions
    )
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
}

export const customerService = Object.freeze(new CustomerService());
