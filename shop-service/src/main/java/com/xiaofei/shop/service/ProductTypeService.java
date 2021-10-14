package com.xiaofei.shop.service;

import com.xiaofei.shop.exception.ProductTypeExistException;
import com.xiaofei.shop.pojo.ProductType;

import java.util.List;

/**
 * Author: madlax
 * Date: 9/8/2021, 6:29 PM
 * Description:
 */
public interface ProductTypeService {
    /*
     * query all productTypes
     * */
    List<ProductType> findAllTypes();

    /*
     * query product type by id
     * */
    ProductType findTypeById(long id);

    /*
     * insert product type, need to determine if already has such a product type
     * if there is, throws exception
     * if not, proceed insert
     * */

    void addProductType(String name) throws ProductTypeExistException;

    /*
     * modify product type name by id
     * */
    void modifyTypeNameById(long id, String name) throws ProductTypeExistException;

    /*
     * modify product type status by id
     * */

    void modifyTypeStatusById( long id);

    /*
     * delete product type by id
     * */

    void removeTypeById(long id);
}
