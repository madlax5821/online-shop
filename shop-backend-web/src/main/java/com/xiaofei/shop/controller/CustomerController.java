package com.xiaofei.shop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.shop.constant.PaginationConstant;
import com.xiaofei.shop.constant.ResponseStatusConstant;
import com.xiaofei.shop.pojo.Customer;
import com.xiaofei.shop.service.CustomerService;
import com.xiaofei.shop.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * Author: madlax
 * Date: 9/10/2021, 3:45 PM
 * Description:
 */
@Controller
@RequestMapping("/backend/customer")
public class CustomerController {

    @Autowired
    private CustomerService service;

    @RequestMapping("/getAllCustomers")
    public String getAllCustomers(Map map, Integer pageNum){
        if (ObjectUtils.isEmpty(pageNum)){
            pageNum = PaginationConstant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
        List<Customer> customers = service.getCustomers();
        PageInfo<Customer> customerPageInfo = new PageInfo<>(customers);
        map.put("customerPageInfo",customerPageInfo);
        return "customerManager";
    }

    @RequestMapping("/getCustomerById")
    @ResponseBody
    public ResponseResult getCustomerById(Long id){
        Customer customer = service.getCustomerById(id);
        return ResponseResult.success(customer);
    }

    @RequestMapping("/changeStatus")
    @ResponseBody
    public ResponseResult changeStatus(Long id){
        Customer customer = service.getCustomerById(id);
        ResponseResult result = new ResponseResult();
        try {
            service.modifyCustomerStatus(customer);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
            result.setMessage("修改状态成功");
        }catch (Exception e){
            result.setMessage(e.getMessage());
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
        }
        return result;
    }

    @RequestMapping("/modifyCustomer")
    @ResponseBody
    public ResponseResult modifyCustomer(Customer customer){
        ResponseResult result = new ResponseResult();
        try {
            service.modifyCustomer(customer);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
            result.setMessage("修改用户成功");
        }catch (Exception e){
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/retrieveCustomer")
    public String retrieveCustomer(Customer customer, Integer pageNum, Map map){
        if (ObjectUtils.isEmpty(pageNum)){
           pageNum=PaginationConstant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
        List<Customer> customers = service.getCustomerByParams(customer);
        PageInfo<Customer> customerPageInfo = new PageInfo<>(customers);
        map.put("customerPageInfo",customerPageInfo);
        return "customerManager";
    }

}
