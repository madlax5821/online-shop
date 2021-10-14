package com.xiaofei.shop.vo;


/**
 * Author: madlax
 * Date: 9/27/2021, 5:38 PM
 * Description:
 */
public class ProductVo {
    private String name;
    private Double minPrice;
    private Double maxPrice;
    private int productTypeId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Double minPrice) {
        this.minPrice = minPrice;
    }

    public Double getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Double maxPrice) {
        this.maxPrice = maxPrice;
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
                "name='" + name + '\'' +
                ", minPrice=" + minPrice +
                ", maxPrice=" + maxPrice +
                ", productTypeId=" + productTypeId +
                '}';
    }
}
