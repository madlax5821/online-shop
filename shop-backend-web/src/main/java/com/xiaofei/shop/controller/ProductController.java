package com.xiaofei.shop.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaofei.shop.constant.PaginationConstant;
import com.xiaofei.shop.constant.ResponseStatusConstant;
import com.xiaofei.shop.dto.ProductDTO;
import com.xiaofei.shop.pojo.Product;
import com.xiaofei.shop.pojo.ProductType;
import com.xiaofei.shop.service.ProductService;
import com.xiaofei.shop.service.ProductTypeService;
import com.xiaofei.shop.util.ResponseResult;
import com.xiaofei.shop.vo.ProductVo;
import org.apache.commons.beanutils.PropertyUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpSession;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

/**
 * Author: madlax
 * Date: 9/9/2021, 6:03 PM
 * Description:
 */
@Controller
@RequestMapping("/backend/product")
public class ProductController {

    @Autowired
    private ProductTypeService service;
    @Autowired
    private ProductService productService;

    @ModelAttribute("productTypes")
    public List<ProductType> loadProductTypes(){
        List<ProductType> types = service.findAllTypes();
        return types;
    }

    @RequestMapping("/getAllProducts")
    public String getAllProducts(Integer pageNum,Map map){
        if (ObjectUtils.isEmpty(pageNum)){
            pageNum= PaginationConstant.PAGE_NUM;
        }
        //configure pageHelper
        PageHelper.startPage(pageNum,PaginationConstant.PAGE_SIZE);

        List<Product> products = productService.findAllProducts();

        PageInfo<Product> pageInfo = new PageInfo<>(products);
        map.put("pageInfo",pageInfo);
        return "productManager";
    }

    @RequestMapping("/addProduct")
    public String add(ProductVo vo, HttpSession session, Map map){
        //transfer vo to DTO
        String uploadPath = session.getServletContext().getRealPath("/WEB-INF/upload");
        ProductDTO productDTO = new ProductDTO();
        try {
            PropertyUtils.copyProperties(productDTO,vo);
            productDTO.setInputStream(vo.getFile().getInputStream());
            productDTO.setFileName(vo.getFile().getOriginalFilename());
            productDTO.setUploadPath(uploadPath);
            productService.addProduct(productDTO);
            map.put("successMsg","添加商品成功");
        } catch (Exception e) {
            //e.printStackTrace();
            map.put("errorMsg",e.getMessage());
        }
        return "forward:getAllProducts";
    }

    @RequestMapping("/modifyProduct")
    public String modifyProduct(ProductVo vo, Map map, HttpSession session, Integer pageNum){
        String path = session.getServletContext().getRealPath("/WEB-INF/upload");
        ProductDTO dto = new ProductDTO();

        try {
            PropertyUtils.copyProperties(dto,vo);
            dto.setInputStream(vo.getFile().getInputStream());
            dto.setFileName(vo.getFile().getOriginalFilename());
            dto.setUploadPath(path);
            map.put("successMsg","修改成功");
            System.out.println(dto);
            productService.modifyProduct(dto);
        } catch (IllegalAccessException | InvocationTargetException | NoSuchMethodException | IOException e) {
            map.put("errorMsg",e.getMessage());
        }
        return "forward:getAllProducts?pageNum="+pageNum;
    }

    @RequestMapping("/removeProduct")
    @ResponseBody
    public ResponseResult removeProduct(long id){
        productService.removeProductById(id);
        ResponseResult result = new ResponseResult();
        result.setStatus(ResponseStatusConstant.RESPONSE_STATUS_SUCCESS);
        result.setMessage("删除成功");
        return result;
    }

    @RequestMapping("/getProduct")
    @ResponseBody
    public ResponseResult getProductById(long id){
        Product product = productService.findProductById(id);
        return ResponseResult.success(product);
    }
    @RequestMapping("/getImage")
    public void getImage(String path, OutputStream outputStream, HttpSession session){
        int slash = path.lastIndexOf("/");
        path = path.substring(slash);
        path = session.getServletContext().getRealPath("WEB-INF/upload"+path);
        System.out.println(path);
        productService.getImage(path,outputStream);
    }
}
