package com.xiaofei.shop.dao;

import com.xiaofei.shop.pojo.Administrator;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * Author: madlax
 * Date: 9/8/2021, 5:43 PM
 * Description:
 */
public interface AdministratorDao {
    /*
    * insert new admin
    * */
    void saveAdmin(Administrator admin);

    /*
    * delete admin
    * */
    void deleteAdminById(long id);

    /*
    * modify admin
    * */
    void updateAdmin(Administrator admin);

    void updateAdminStatus(Administrator admin);

    /*
    * select all admins
    * */
    List<Administrator> getAdmins();

    /*
    * get admin by id
    * */
    Administrator getAdminById(long id);

    /*get admin by dynamic parameter*/
    List<Administrator> getAdminByParam(Administrator admin);

    /*get admin by account name*/
    Administrator getAdminByAccName(String loginName);

    Administrator getAdminByName(String name);

    Administrator getAdminByCredential(@Param("loginName") String loginName, @Param("password") String password);
}
