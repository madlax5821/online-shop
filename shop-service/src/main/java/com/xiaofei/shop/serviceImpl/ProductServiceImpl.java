package com.xiaofei.shop.serviceImpl;

import com.xiaofei.shop.dao.ProductDao;
import com.xiaofei.shop.dao.ProductTypeDao;
import com.xiaofei.shop.dto.ProductDTO;
import com.xiaofei.shop.exception.FileUploadException;
import com.xiaofei.shop.exception.ProductExistException;
import com.xiaofei.shop.pojo.Product;
import com.xiaofei.shop.pojo.ProductType;
import com.xiaofei.shop.service.ProductService;
import com.xiaofei.shop.util.StringUtils;
import com.xiaofei.shop.vo.ProductVo;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StreamUtils;

import java.io.*;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

/**
 * Author: madlax
 * Date: 9/9/2021, 6:41 PM
 * Description:
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,rollbackFor = Exception.class)
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductDao productDao;
    @Autowired
    private ProductTypeDao productTypeDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public List<Product> findAllProducts() {
        return productDao.getAllProducts();
    }

    @Override
    @Transactional(propagation = Propagation.SUPPORTS, readOnly = true)
    public Product findProductById(long id) {
        return productDao.getProductById(id);
    }

    @Override
    public Product findProductByName(String name) {
        return productDao.getProductByName(name);
    }

    @Override
    public void addProduct(ProductDTO productDTO) throws FileUploadException, InvocationTargetException, IllegalAccessException, NoSuchMethodException, ProductExistException {
        //1. file upload
        System.out.println("prepare file upload");
        String fileName = StringUtils.renameFileName(productDTO.getFileName());
        String filePath = productDTO.getUploadPath()+"/"+fileName;
        try {
            StreamUtils.copy(productDTO.getInputStream(),new FileOutputStream(filePath));
        } catch (Exception e) {
            throw new FileUploadException("file failed uploaded:"+e.getMessage());
        }
        //2. store in database
        //将DTO转换为POJO
        Product product = new Product();
        PropertyUtils.copyProperties(product,productDTO);
        if (productDao.getProductByName(product.getName())!=null){
            throw new ProductExistException("product already existed");
        }
        product.setImage("pictures/"+fileName);
        //ProductType productType = productTypeDao.getProductTypeById(productDTO.getProductTypeId());
        ProductType productType = new ProductType();
        productType.setId(productDTO.getProductTypeId());
        product.setProductType(productType);
        productDao.saveProduct(product);
    }

    @Override
    public void modifyProduct(ProductDTO productDTO) throws IOException, InvocationTargetException, IllegalAccessException, NoSuchMethodException {
        String fileName = StringUtils.renameFileName(productDTO.getFileName());
        String filePath=productDTO.getUploadPath()+"/"+fileName;
        StreamUtils.copy(productDTO.getInputStream(),new FileOutputStream(filePath));

        Product product = new Product();
        PropertyUtils.copyProperties(product,productDTO);
        product.setImage("pictures/"+fileName);
        ProductType type = productTypeDao.getProductTypeById(productDTO.getProductTypeId());
        product.setProductType(type);
        productDao.updateProduct(product);
    }

    @Override
    public void removeProductById(long id) {
        productDao.deleteProductById(id);
    }

    @Override
    public List<Product> findProductByParam(ProductVo vo) {
        System.out.println(vo.getName()+"|"+vo.getMinPrice()+"|"+vo.getMaxPrice()+"|"+vo.getProductTypeId());
        return productDao.getProductByParam(vo);
    }

    @Override
    public void getImage(String path, OutputStream outputStream) {
        try {
            StreamUtils.copy(new FileInputStream(path),outputStream);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
