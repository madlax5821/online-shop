package com.xiaofei.shop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.shop.constant.PaginationConstant;
import com.xiaofei.shop.pojo.Product;
import com.xiaofei.shop.pojo.ProductType;
import com.xiaofei.shop.service.ProductService;
import com.xiaofei.shop.service.ProductTypeService;
import com.xiaofei.shop.vo.ProductVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Author: madlax
 * Date: 9/27/2021, 12:58 PM
 * Description:
 */
@Controller
@RequestMapping("/frontend/product")
public class ProductController {
    @Autowired
    private ProductTypeService productTypeService;

    @Autowired
    private ProductService productService;

    @RequestMapping("/searchProduct")
    public String search(ProductVo vo,Integer pageNum, Model model){
        if (ObjectUtils.isEmpty(pageNum)){
            pageNum= PaginationConstant.PAGE_NUM;
        }
        PageHelper.startPage(pageNum,8);
        List<Product> products = productService.findProductByParam(vo);
        PageInfo<Product> pageInfo = new PageInfo<>(products);
        model.addAttribute("productPageInfo",pageInfo);
        return "main";
    }

    @ModelAttribute("productTypes")
    public List<ProductType> getProductTypes(){
        return productTypeService.findAllTypes();
    }
}
