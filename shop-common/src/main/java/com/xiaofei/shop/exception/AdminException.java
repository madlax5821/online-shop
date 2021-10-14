package com.xiaofei.shop.exception;

/**
 * Author: madlax
 * Date: 9/10/2021, 5:20 PM
 * Description:
 */
public class AdminException extends Exception{
    public AdminException() {
        super();
    }

    public AdminException(String message) {
        super(message);
    }

    public AdminException(String message, Throwable cause) {
        super(message, cause);
    }

    public AdminException(Throwable cause) {
        super(cause);
    }
}
