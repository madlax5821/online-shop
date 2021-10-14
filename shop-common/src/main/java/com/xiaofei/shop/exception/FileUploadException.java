package com.xiaofei.shop.exception;

/**
 * Author: madlax
 * Date: 9/9/2021, 7:21 PM
 * Description:
 */
public class FileUploadException extends Exception{
    public FileUploadException() {
        super();
    }

    public FileUploadException(String message) {
        super(message);
    }

    public FileUploadException(String message, Throwable cause) {
        super(message, cause);
    }

    public FileUploadException(Throwable cause) {
        super(cause);
    }
}
