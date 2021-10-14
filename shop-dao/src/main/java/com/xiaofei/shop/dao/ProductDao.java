package com.xiaofei.shop.dao;

import com.xiaofei.shop.pojo.Product;
import com.xiaofei.shop.pojo.ProductType;
import com.xiaofei.shop.vo.ProductVo;

import java.util.List;

/**
 * Author: madlax
 * Date: 9/9/2021, 6:16 PM
 * Description:
 */
public interface ProductDao {

    /*
    * query all products
    * */
    List<Product> getAllProducts();

    /*
     * get product by dynamic parameters
     * */
    List<Product> getProductByParam(ProductVo vo);

    /*
    * query product by id
    * */
    Product getProductById(long id);

    /*
    * query product by name
    * */
    Product getProductByName(String name);

    /*
    * insert product
    * */
    void saveProduct(Product product);

    /*
    * update product
    * */
    void updateProduct(Product product);

    /*
    * delete product by id
    * */
    void deleteProductById(long id);

}
