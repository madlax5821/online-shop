package com.xiaofei.shop.pojo;

/**
 * Author: madlax
 * Date: 9/8/2021, 5:33 PM
 * Description:
 */
public class ProductType {
    private long id;
    private String name;
    private int status;

    public ProductType() {
    }

    public ProductType(long id, String name, int status) {
        this.id = id;
        this.name = name;
        this.status = status;
    }

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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "ProductType{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", status=" + status +
                '}';
    }
}
