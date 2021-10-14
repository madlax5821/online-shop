package com.xiaofei.shop.dao;

import com.xiaofei.shop.pojo.Customer;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Author: madlax
 * Date: 9/22/2021, 10:58 PM
 * Description:
 */
public interface CustomerDao {
    void saveCustomer(Customer customer);
    void deleteCustomerById(Long id);
    void updateCustomer(Customer customer);
    void updateCustomerStatus(Customer customer);
    List<Customer> getCustomers();
    Customer getCustomerByAccName(String loginName);
    Customer getCustomerById(Long id);
    List<Customer> getCustomerByParams(Customer customer);
    Customer getCustomerByCredential(@Param("loginName") String loginName, @Param("password") String password);
    Customer getCustomerByPhone(String phone);
    Customer getCustomerByName(String name);
}
