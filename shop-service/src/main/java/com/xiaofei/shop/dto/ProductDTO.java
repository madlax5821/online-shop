package com.xiaofei.shop.dto;

import java.io.InputStream;

/**
 * Author: madlax
 * Date: 9/9/2021, 6:58 PM
 * Description: (DTO)Data Transfer Object
 */
public class ProductDTO {
    private long id;
    private String name;
    private double price;
    private int productTypeId;
    private InputStream inputStream; //文件输入流
    private String fileName; //file name
    private String uploadPath; //file upload path

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

    public void setPrice(double price) {
        this.price = price;
    }

    public int getProductTypeId() {
        return productTypeId;
    }

    public void setProductTypeId(int productTypeId) {
        this.productTypeId = productTypeId;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getUploadPath() {
        return uploadPath;
    }

    public void setUploadPath(String uploadPath) {
        this.uploadPath = uploadPath;
    }

    @Override
    public String toString() {
        return "ProductDTO{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", productTypeId=" + productTypeId +
                ", inputStream=" + inputStream +
                ", fileName='" + fileName + '\'' +
                ", uploadPath='" + uploadPath + '\'' +
                '}';
    }
}
