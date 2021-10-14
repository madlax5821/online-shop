package com.xiaofei.shop.dao;

import com.xiaofei.shop.pojo.Role;

import java.util.List;

/**
 * Author: madlax
 * Date: 9/25/2021, 10:50 PM
 * Description:
 */
public interface RoleDao {
    List<Role> getRoles();
    Role getRoleById(long id);
}
