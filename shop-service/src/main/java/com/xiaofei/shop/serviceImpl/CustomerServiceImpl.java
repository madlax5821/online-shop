package com.xiaofei.shop.serviceImpl;

import com.xiaofei.shop.constant.CustomerConstant;
import com.xiaofei.shop.dao.CustomerDao;
import com.xiaofei.shop.exception.CustomerException;
import com.xiaofei.shop.pojo.Customer;
import com.xiaofei.shop.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

/**
 * Author: madlax
 * Date: 9/22/2021, 11:34 PM
 * Description:
 */
@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerDao customerDao;

    @Override
    public void register(Customer customer) throws CustomerException {
        if (customerDao.getCustomerByAccName(customer.getLoginName())!=null){
            throw new CustomerException("login name is already exist");
        }
        if (customerDao.getCustomerByName(customer.getName())!=null){
            throw new CustomerException("username is already exist");
        }
        customer.setIsValid(CustomerConstant.MEMBER_ENABLE);
        customer.setRegisterDate(new Date());
        customerDao.saveCustomer(customer);
    }

    @Override
    public void removeCustomer(Long id) {

    }

    @Override
    public void modifyCustomer(Customer customer) throws CustomerException {
        Customer customer1 = customerDao.getCustomerByAccName(customer.getLoginName());
        if (customerDao.getCustomerByName(customer.getName())!=null&&!customer1.getName().equals(customer.getName())){
            throw new CustomerException("username has been used");
        }
        customerDao.updateCustomer(customer);
    }

    @Override
    public void modifyCustomerStatus(Customer customer) {
        Integer isValid = customer.getIsValid();
        if (isValid== CustomerConstant.MEMBER_ENABLE){
            isValid=CustomerConstant.MEMBER_DISABLE;
        }else {
            isValid=CustomerConstant.MEMBER_ENABLE;
        }
        customer.setIsValid(isValid);
        customerDao.updateCustomerStatus(customer);
    }

    @Override
    public List<Customer> getCustomers() {
        return customerDao.getCustomers();
    }

    @Override
    public Customer getCustomerByAccName(String loginName) {
        return customerDao.getCustomerByAccName(loginName);
    }

    @Override
    public Customer getCustomerById(Long id) {
        return customerDao.getCustomerById(id);
    }

    @Override
    public List<Customer> getCustomerByParams(Customer customer) {
        return customerDao.getCustomerByParams(customer);
    }

    @Override
        public Customer loginByAccount(String loginName, String password) throws CustomerException {
        Customer customer = customerDao.getCustomerByCredential(loginName, password);
        if (customer==null){
            throw new CustomerException("invalid username or password");
        }else if(customer.getIsValid()!=1){
            throw new CustomerException("this account has been locked");
        }
        return customer;
    }

    @Override
    public Customer getCustomerByPhone(String phone) {
        return customerDao.getCustomerByPhone(phone);
    }
}
