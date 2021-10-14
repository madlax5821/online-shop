package com.xiaofei.shop.dao;

import com.xiaofei.shop.pojo.ProductType;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Author: madlax
 * Date: 9/8/2021, 5:43 PM
 * Description:
 */
public interface ProductTypeDao {
    /*
    * query all productTypes
    * */
    List<ProductType> getProductTypes();

    /*
    * query product type by id
    * */
    ProductType getProductTypeById(long id);

    /*
    * query product type by name
    * */

    ProductType getProductTypeByName(String name);

    /*
    * insert product type
    * */

    //void saveProductType(@Param("name")String name,@Param("status")int status);
    void saveProductType(Map<String ,Object> map);

    /*
    * modify product type name by id
    * */
    void updateProductTypeNameById(@Param("id") long id, @Param("name") String name);

    /*
     * modify product type status by id
     * */

    void updateProductTypeStatusById(@Param("id") long id, @Param("status") int status);

    /*
    * delete product type by id
    * */

    void deleteProductTypeById(long id);
}
