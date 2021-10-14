package com.xiaofei.shop.service;

import com.xiaofei.shop.dto.AdminDto;
import com.xiaofei.shop.exception.AdminException;
import com.xiaofei.shop.pojo.Administrator;

import java.lang.reflect.InvocationTargetException;
import java.util.List;

/**
 * Author: madlax
 * Date: 9/8/2021, 8:23 PM
 * Description:
 */
public interface AdministratorService {
    /*
     * insert new admin
     * */
    void insertAdmin(AdminDto dto) throws Exception;

    /*
     * delete admin
     * */
    void removeAdminById(long id);

    /*
     * modify admin
     * */
    void modifyAdmin(AdminDto dto) throws InvocationTargetException, IllegalAccessException, NoSuchMethodException;

    /*
     * select all admins
     * */
    List<Administrator> findAllAdmins();

    /*
     * get admin by id
     * */
    Administrator findAdminById(long id);

    /*get admin by dynamic parameter*/
    List<Administrator> findAdminByParam(AdminDto dto) throws InvocationTargetException, IllegalAccessException, NoSuchMethodException;

    /*get admin by account name or name*/
    Administrator findAdminByAccName(String loginName);
    Administrator findAdminByName(String name);

    /*
    * modify admin status
    * */
    void changeAdminStatus(long id);

    boolean login(String loginName, String password) throws AdminException;
}
