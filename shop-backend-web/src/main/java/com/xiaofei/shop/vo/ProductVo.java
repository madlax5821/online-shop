package com.xiaofei.shop.vo;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * Author: madlax
 * Date: 9/9/2021, 6:52 PM
 * Description:
 */
public class ProductVo {
    private long id;
    private String name;
    private Double price;
    private CommonsMultipartFile file;
    private int productTypeId;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public CommonsMultipartFile getFile() {
        return file;
    }

    public void setFile(CommonsMultipartFile file) {
        this.file = file;
    }

    public int getProductTypeId() {
        return productTypeId;
    }

    public void setProductTypeId(int productTypeId) {
        this.productTypeId = productTypeId;
    }

    @Override
    public String toString() {
        return "ProductVo{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", file=" + file +
                ", productTypeId=" + productTypeId +
                '}';
    }
}
