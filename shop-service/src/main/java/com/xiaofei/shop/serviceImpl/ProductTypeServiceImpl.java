package com.xiaofei.shop.serviceImpl;

import com.xiaofei.shop.constant.ProductTypeConstant;
import com.xiaofei.shop.dao.ProductTypeDao;
import com.xiaofei.shop.exception.ProductTypeExistException;
import com.xiaofei.shop.pojo.ProductType;
import com.xiaofei.shop.service.ProductTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author: madlax
 * Date: 9/8/2021, 6:34 PM
 * Description:
 */

@Service
@Transactional(propagation = Propagation.REQUIRED, rollbackFor = Exception.class)
public class ProductTypeServiceImpl implements ProductTypeService {
    @Autowired
    private ProductTypeDao productTypeDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public List<ProductType> findAllTypes() {
        return productTypeDao.getProductTypes();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS,readOnly = true)
    public ProductType findTypeById(long id) {
        return productTypeDao.getProductTypeById(id);
    }

    @Override
    public void addProductType(String name) throws ProductTypeExistException {
        if (productTypeDao.getProductTypeByName(name)!=null){
            throw new ProductTypeExistException("the product type already existed");
        }
        Map<String, Object> map = new HashMap<>();
        map.put("name",name);
        map.put("status",ProductTypeConstant.PRODUCT_TYPE_ENABLE);
        //productTypeDao.saveProductType(name, ProductTypeConstant.PRODUCT_TYPE_ENABLE);
        productTypeDao.saveProductType(map);

    }

    @Override
    public void modifyTypeNameById(long id, String name) throws ProductTypeExistException{
        ProductType type = productTypeDao.getProductTypeById(id);
        if (!type.getName().equals(name)&&productTypeDao.getProductTypeByName(name)!=null){
            throw new ProductTypeExistException("the product type already existed");
        }
        productTypeDao.updateProductTypeNameById(id,name);
    }

    @Override
    public void modifyTypeStatusById(long id) {
        ProductType type = productTypeDao.getProductTypeById(id);
        if (type.getStatus()==ProductTypeConstant.PRODUCT_TYPE_ENABLE){
            productTypeDao.updateProductTypeStatusById(id,ProductTypeConstant.PRODUCT_TYPE_DISABLE);
        }else {
            productTypeDao.updateProductTypeStatusById(id,ProductTypeConstant.PRODUCT_TYPE_ENABLE);
        }
    }

    @Override
    public void removeTypeById(long id) {
        productTypeDao.deleteProductTypeById(id);
    }
}
