package com.xiaofei.shop.util;

import com.xiaofei.shop.constant.ResponseStatusConstant;

/**
 * Author: madlax
 * Date: 9/8/2021, 11:32 PM
 * Description:
 */
public class ResponseResult {

    /*response code*/
    private int status;
    /*response info*/
    private String message;
    /*response data*/
    private Object data;

    public ResponseResult() {
    }

    public ResponseResult(int status, String message) {
        this.status = status;
        this.message = message;
    }

    public ResponseResult(int status, String message, Object data) {
        this.status = status;
        this.message = message;
        this.data = data;
    }

    //成功
    public static ResponseResult success(Object data){
        return new ResponseResult(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS,"success",data);
    }

    public static ResponseResult success(){
        return new ResponseResult(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS,"success");
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
