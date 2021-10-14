package com.xiaofei.shop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.shop.constant.PaginationConstant;
import com.xiaofei.shop.constant.ResponseStatusConstant;
import com.xiaofei.shop.dto.AdminDto;
import com.xiaofei.shop.exception.AdminException;
import com.xiaofei.shop.pojo.Administrator;
import com.xiaofei.shop.service.AdministratorService;
import com.xiaofei.shop.util.ResponseResult;
import com.xiaofei.shop.vo.AdminVo;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.InvocationTargetException;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

/**
 * Author: madlax
 * Date: 9/8/2021, 8:22 PM
 * Description:
 */
@Controller
@RequestMapping("/backend/admin")
public class AdminController {

    @Autowired
    private AdministratorService service;


    @RequestMapping("/login")
    public String login(String loginName, String password, HttpSession session, HttpServletRequest req){
        //处理登录操作
        try {
            if (service.login(loginName,password)){
                session.setAttribute("loginName",loginName);
                return "main";
            }
        } catch (AdminException e) {
            req.setAttribute("loginError",e.getMessage());
        }
        return "login";
    }

    @RequestMapping("/logout")
    public String logout(String loginName, HttpSession session, Model model){
        session.removeAttribute(loginName);
        model.addAttribute("logout","logout successfully");
        return "login";
    }

    @RequestMapping("/getAllAdmins")
    public String getAllAdmins(Integer pageNum, Model model){

        if (ObjectUtils.isEmpty(pageNum)){
            pageNum= PaginationConstant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
        List<Administrator> admins=service.findAllAdmins();
        PageInfo<Administrator> pageInfo = new PageInfo<>(admins);
        model.addAttribute("adminPageInfo",pageInfo);
        return "sysuserManager";
    }

    @RequestMapping("/getAdminById")
    @ResponseBody
    public ResponseResult getAdminById(Long id){
        Administrator admin = service.findAdminById(id);
        return ResponseResult.success(admin);
    }

    @RequestMapping("/modifyAdmin")
    @ResponseBody
    public ResponseResult modifyAdmin(AdminVo vo){
        ResponseResult result = new ResponseResult();
        AdminDto dto = new AdminDto();
        try {
            PropertyUtils.copyProperties(dto,vo);
            service.modifyAdmin(dto);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
            result.setMessage("修改成功");
        } catch (Exception e) {
            //e.printStackTrace();
            result.setMessage(e.getMessage());
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
        }
        return result;
    }

    @RequestMapping("/changeStatus")
    @ResponseBody
    public ResponseResult changeAdminStatus(long id){
        ResponseResult result = new ResponseResult();
        try {
            service.changeAdminStatus(id);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);

        }catch (Exception e){
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/addAdmin")
    @ResponseBody
    public ResponseResult addAdmin(AdminVo vo){
        ResponseResult result = new ResponseResult();
        AdminDto dto = new AdminDto();
        try {
            PropertyUtils.copyProperties(dto,vo);
            service.insertAdmin(dto);
            result.setMessage("添加管理员成功");
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        } catch (Exception e) {
            //e.printStackTrace();
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/searchAdmin")
    public String searchAdmin(AdminVo vo, Integer pageNum, Model model){
        if (ObjectUtils.isEmpty(pageNum)){
            pageNum=PaginationConstant.PAGE_NUM;
        }
        AdminDto dto = new AdminDto();
        try {
            PropertyUtils.copyProperties(dto,vo);PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);
            List<Administrator> admins = service.findAdminByParam(dto);
            PageInfo<Administrator> pageInfo = new PageInfo<>(admins);
            model.addAttribute("adminPageInfo",pageInfo);
            model.addAttribute("adminParam",vo);
        } catch (Exception e) {
            model.addAttribute("error",e.getMessage());
        }

        return "sysuserManager";
    }
}
