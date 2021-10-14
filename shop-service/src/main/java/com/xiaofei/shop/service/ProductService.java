package com.xiaofei.shop.service;

import com.xiaofei.shop.dto.ProductDTO;
import com.xiaofei.shop.exception.FileUploadException;
import com.xiaofei.shop.exception.ProductExistException;
import com.xiaofei.shop.pojo.Product;
import com.xiaofei.shop.vo.ProductVo;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

/**
 * Author: madlax
 * Date: 9/9/2021, 6:40 PM
 * Description:
 */
public interface ProductService {
    /*
     * query all products
     * */
    List<Product> findAllProducts();

    /*
     * query product by id
     * */
    Product findProductById(long id);

    /*
     * query product by name
     * */
    Product findProductByName(String name);

    /*
     * insert product
     * */
    void addProduct(ProductDTO productDTO) throws FileUploadException, InvocationTargetException, IllegalAccessException, NoSuchMethodException, ProductExistException;

    /*
     * update product
     * */
    void modifyProduct(ProductDTO productDTO) throws IOException, InvocationTargetException, IllegalAccessException, NoSuchMethodException;

    /*
     * delete product by id
     * */
    void removeProductById(long id);

    List<Product> findProductByParam(ProductVo vo);

    void getImage(String path, OutputStream outputStream);
}
