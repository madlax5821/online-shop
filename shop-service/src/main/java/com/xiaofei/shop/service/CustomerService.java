package com.xiaofei.shop.service;

import com.xiaofei.shop.exception.CustomerException;
import com.xiaofei.shop.pojo.Customer;

import java.util.List;

/**
 * Author: madlax
 * Date: 9/22/2021, 11:33 PM
 * Description:
 */
public interface CustomerService {
    void register(Customer customer) throws CustomerException;
    void removeCustomer(Long id);
    void modifyCustomer(Customer customer) throws CustomerException;
    void modifyCustomerStatus(Customer customer);
    List<Customer> getCustomers();
    Customer getCustomerByAccName(String loginName);
    Customer getCustomerById(Long id);
    List<Customer> getCustomerByParams(Customer customer);
    Customer loginByAccount(String loginName, String password) throws CustomerException;
    Customer getCustomerByPhone(String phone);
}
