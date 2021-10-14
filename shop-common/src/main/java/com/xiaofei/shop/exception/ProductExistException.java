package com.xiaofei.shop.exception;

/**
 * Author: madlax
 * Date: 9/10/2021, 2:38 PM
 * Description:
 */
public class ProductExistException extends Exception{
    public ProductExistException() {
        super();
    }

    public ProductExistException(String message) {
        super(message);
    }

    public ProductExistException(String message, Throwable cause) {
        super(message, cause);
    }

    public ProductExistException(Throwable cause) {
        super(cause);
    }
}
