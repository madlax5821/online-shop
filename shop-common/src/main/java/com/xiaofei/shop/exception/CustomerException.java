package com.xiaofei.shop.exception;

/**
 * Author: madlax
 * Date: 9/29/2021, 2:20 PM
 * Description:
 */
public class CustomerException extends Exception{
    public CustomerException() {
        super();
    }

    public CustomerException(String message) {
        super(message);
    }

    public CustomerException(String message, Throwable cause) {
        super(message, cause);
    }

    public CustomerException(Throwable cause) {
        super(cause);
    }
}
