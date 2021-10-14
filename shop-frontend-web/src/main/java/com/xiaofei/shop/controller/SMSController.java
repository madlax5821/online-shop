package com.xiaofei.shop.controller;

import com.twilio.Twilio;
import com.twilio.rest.api.v2010.account.Message;
import com.xiaofei.shop.constant.ResponseStatusConstant;
import com.xiaofei.shop.pojo.Customer;
import com.xiaofei.shop.service.CustomerService;
import com.xiaofei.shop.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Random;




/**
 * Author: madlax
 * Date: 10/3/2021, 12:05 AM
 * Description:
 */
@Controller
@RequestMapping("/frontend/SMS")
public class SMSController {
    @Value("${twilio.username}")
    private String twilioUserName;
    @Value("${twilio.password}")
    private String twilioPassword;
    @Value("${twilio.serviceId}")
    private String serviceId;
    /*set up the verification code expired time in seconds*/
    private final Integer VERIFICATION_CODE_EXPIRED_TIME=120;

    @Autowired
    private CustomerService customerService;

    @RequestMapping("/sendCode")
    @ResponseBody
    public ResponseResult sendCode(String phone, HttpSession session){
        ResponseResult result = new ResponseResult();
        Customer customer = customerService.getCustomerByPhone(phone);
        if (customer ==null){
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
            result.setMessage("this phone number is not registered yet");
            return result;
        }
        Random random = new Random();
        String code = "";
        for (int i=0;i<6;i++){
            code+=random.nextInt(9);
        }
        session.setAttribute(phone,code);
        session.setMaxInactiveInterval(VERIFICATION_CODE_EXPIRED_TIME);
        Twilio.init(twilioUserName, twilioPassword);
        Message message = Message.creator(
                new com.twilio.type.PhoneNumber(phone),
                serviceId,
                "尊敬的"+customer.getName()+",您的验证码是:"+code)
                .create();
        result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        result.setMessage("send code successfully");
        result.setData(customer);
        return result;
    }
}
