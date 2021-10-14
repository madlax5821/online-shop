package com.xiaofei.shop.serviceImpl;

import com.xiaofei.shop.constant.AdminConstant;
import com.xiaofei.shop.dao.AdministratorDao;
import com.xiaofei.shop.dao.RoleDao;
import com.xiaofei.shop.dto.AdminDto;
import com.xiaofei.shop.exception.AdminException;
import com.xiaofei.shop.pojo.Administrator;
import com.xiaofei.shop.pojo.Role;
import com.xiaofei.shop.service.AdministratorService;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.lang.reflect.InvocationTargetException;
import java.util.Date;
import java.util.List;

/**
 * Author: madlax
 * Date: 9/8/2021, 8:24 PM
 * Description:
 */
@Service
@Transactional (propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class AdministratorServiceImpl implements AdministratorService {

    @Autowired
    private AdministratorDao adminDao;

    @Autowired
    private RoleDao roleDao;

    @Override
    public void insertAdmin(AdminDto dto) throws Exception {
        Administrator admin = new Administrator();
        PropertyUtils.copyProperties(admin,dto);
        Role role = roleDao.getRoleById(dto.getRoleId());
        if (adminDao.getAdminByAccName(admin.getLoginName())!=null){
            throw new AdminException("account name has been used");
        }
        admin.setIsValid(AdminConstant.Member_ENABLE);
        admin.setCreateDate(new Date());
        admin.setRole(role);

        System.out.println(admin);
        adminDao.saveAdmin(admin);
    }

    @Override
    public void removeAdminById(long id) {
        adminDao.deleteAdminById(id);
    }

    @Override
    public void modifyAdmin(AdminDto dto) throws InvocationTargetException, IllegalAccessException, NoSuchMethodException {
        Administrator admin = new Administrator();
        PropertyUtils.copyProperties(admin,dto);
        Role role = roleDao.getRoleById(dto.getRoleId());
        admin.setRole(role);
        System.out.println(role);
        System.out.println(dto);
        adminDao.updateAdmin(admin);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<Administrator> findAllAdmins() {
        return adminDao.getAdmins();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Administrator findAdminById(long id) {
        return adminDao.getAdminById(id);
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<Administrator> findAdminByParam(AdminDto dto) throws InvocationTargetException, IllegalAccessException, NoSuchMethodException {
        Administrator admin = new Administrator();
        PropertyUtils.copyProperties(admin,dto);
        Role role = roleDao.getRoleById(dto.getRoleId());
        admin.setRole(role);
        System.out.println(admin);
        System.out.println(dto);
        return adminDao.getAdminByParam(admin);
    }

    @Override
    @Transactional (propagation = Propagation.SUPPORTS, readOnly = true)
    public Administrator findAdminByAccName(String loginName) {
        return adminDao.getAdminByAccName(loginName);
    }

    @Override
    @Transactional (propagation = Propagation.SUPPORTS, readOnly = true)
    public Administrator findAdminByName(String name) {
        return adminDao.getAdminByName(name);
    }

    @Override
    public void changeAdminStatus(long id) {
        Administrator admin = adminDao.getAdminById(id);
        int isValid = admin.getIsValid();
        if (isValid==AdminConstant.Member_ENABLE){
            isValid=AdminConstant.Member_DISABLE;
        }else {
            isValid=AdminConstant.Member_ENABLE;
        }
        admin.setIsValid(isValid);
        adminDao.updateAdminStatus(admin);
    }

    @Override
    public boolean login(String loginName, String password) throws AdminException {
        Administrator admin = adminDao.getAdminByCredential(loginName, password);
        if (admin==null){
            throw new AdminException("username or password not valid");
        }else if(admin.getIsValid()!=1){
            throw new AdminException("this account has been locked");
        }
        return true;
    }
}
