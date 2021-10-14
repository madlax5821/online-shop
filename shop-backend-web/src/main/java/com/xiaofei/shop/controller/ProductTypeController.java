package com.xiaofei.shop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.shop.constant.PaginationConstant;
import com.xiaofei.shop.constant.ResponseStatusConstant;
import com.xiaofei.shop.exception.ProductTypeExistException;
import com.xiaofei.shop.pojo.ProductType;
import com.xiaofei.shop.service.ProductTypeService;
import com.xiaofei.shop.util.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Map;

/**
 * Author: madlax
 * Date: 9/8/2021, 8:29 PM
 * Description:
 */
@Controller
@RequestMapping("/backend/productType")
public class ProductTypeController {

    @Autowired
    private ProductTypeService service;

    @RequestMapping("/getAllTypes")
    public String getAllTypes(Integer pageNum, Map map){
        if (ObjectUtils.isEmpty(pageNum)){
            pageNum= PaginationConstant.PAGE_NUM;
        }
        //设置分页
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);

        //处理业务
        List<ProductType> productTypes = service.findAllTypes();

        /*
        * 将所有数据进行分页设置，封装pageInfo对象
        * */
        PageInfo<ProductType> pageInfo= new PageInfo<>(productTypes);
        map.put("pageInfo",pageInfo);//放入request scope
        return "productTypeManager";
    }

    @RequestMapping("/addType")
    @ResponseBody
    public ResponseResult addType(String name){
        ResponseResult result = new ResponseResult();
        try {
            service.addProductType(name);
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
            result.setMessage("添加成功");
        } catch (ProductTypeExistException e) {
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/getTypeById")
    @ResponseBody
    public ResponseResult getTypeById(long id){
        ProductType type = service.findTypeById(id);
        return ResponseResult.success(type);
    }

    @RequestMapping("/modifyTypeName")
    @ResponseBody
    public ResponseResult modifyTypeName(long id, String name){
        ResponseResult result = new ResponseResult();
        try {
            service.modifyTypeNameById(id,name);
            result.setMessage("修改成功");
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        } catch (ProductTypeExistException e) {
            result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_FAILED);
            result.setMessage(e.getMessage());
        }
        return result;
    }

    @RequestMapping("/deleteTypeById")
    @ResponseBody
    public ResponseResult deleteTypeById(long id){
        ResponseResult result = new ResponseResult();
        service.removeTypeById(id);
        result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        result.setMessage("删除成功");
        return result;
    }

    @RequestMapping("/modifyTypeStatus")
    @ResponseBody
    public ResponseResult modifyTypeStatus(long id){
        ResponseResult result = new ResponseResult();
        service.modifyTypeStatusById(id);
        result.setData(service.findTypeById(id));
        result.setMessage("修改状态成功");
        result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        return result;
    }
}
