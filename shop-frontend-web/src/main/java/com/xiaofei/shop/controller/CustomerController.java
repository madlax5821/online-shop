package com.xiaofei.shop.controller;

import com.xiaofei.shop.constant.ResponseStatusConstant;
import com.xiaofei.shop.exception.CustomerException;
import com.xiaofei.shop.pojo.Customer;
import com.xiaofei.shop.service.CustomerService;
import com.xiaofei.shop.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * Author: madlax
 * Date: 9/29/2021, 2:22 PM
 * Description:
 */
@Controller
@RequestMapping("/frontend/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @RequestMapping("/loginByAccount")
    @ResponseBody
    public ResponseResult loginByAccount(String loginName, String password, HttpSession session){
        ResponseResult result = new ResponseResult();
        try {
            Customer customer = customerService.loginByAccount(loginName, password);
            result.setMessage("login successful");
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
            result.setData(customer);
            session.setAttribute("customer",customer);

        } catch (CustomerException e) {
            //e.printStackTrace();
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/loginBySMS")
    @ResponseBody
    public ResponseResult loginBySMS(String phone, String verificationCode, HttpSession session){
        String code = (String) session.getAttribute(phone);
        ResponseResult result = new ResponseResult();
        if (code==null){
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
            result.setMessage("verification code doesn't exist or has expired");
            return result;
        }
        if (!verificationCode.equals(code)){
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
            result.setMessage("inaccurate verification code");
        }else {
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
            result.setData(customerService.getCustomerByPhone(phone));
            result.setMessage("login successful");
            session.setAttribute("customer",customerService.getCustomerByPhone(phone));
        }
        return result;
    }

    @RequestMapping("/logout")
    @ResponseBody
    public ResponseResult logout(HttpSession session){
        session.invalidate();
        return ResponseResult.success();
    }

    @RequestMapping("/register")
    @ResponseBody
    public ResponseResult register(Customer customer){
        ResponseResult result = new ResponseResult();
        try {
            customerService.register(customer);
            result.setMessage("register successful");
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        }catch (Exception e){
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/personalCenter")
    public String personalCenter(long id, Model model){
        if(model.getAttribute("customer")!=null){
            return "center";
        }
        Customer customer = customerService.getCustomerById(id);
        model.addAttribute("customer",customer);
        return "center";
    }

    @RequestMapping("/modify")
    public String modifyCustomer(Customer customer){
        return "forward:personalCenter";
    }
}
