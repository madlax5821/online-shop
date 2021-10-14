package com.xiaofei.shop.exception;

/**
 * Author: madlax
 * Date: 9/8/2021, 6:44 PM
 * Description:
 */
public class ProductTypeExistException extends Exception{
    public ProductTypeExistException() {
        super();
    }

    public ProductTypeExistException(String message) {
        super(message);
    }

    public ProductTypeExistException(String message, Throwable cause) {
        super(message, cause);
    }

    public ProductTypeExistException(Throwable cause) {
        super(cause);
    }
}
