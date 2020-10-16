package com.kh.mate.product.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.google.gson.JsonObject;
import com.kh.mate.common.Utils;
import com.kh.mate.product.model.service.ProductService;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/product")
@Slf4j
public class ProductController {

	@Autowired
	private ProductService productService;
	
	//JW
	
	//상품 상세정보 보기
	@RequestMapping("/productDetail.do")
	public String productDetail(@RequestParam("productNo") String productNo,
								Model model) {
		log.debug("productNo = {}", productNo);
		//DB에 저장되어있는 데이터를 가져와서 넘겨주기.
		Product product = productService.selectProductOne(productNo);
		log.debug("product = {}", product);
		model.addAttribute("product", product);
		
		return "product/productDetail";
	}
	
	@RequestMapping("/saveCart.do")
	public String saveCart (@RequestParam("amount") String amount,
							@RequestParam("productNo") String productNo,
							@RequestParam("memberId") String memberId){
		
		log.debug("amount = {}",amount);
		log.debug("productNo={}",productNo);
		Map<String, Object> param = new HashMap<>();
		param.put("amount", amount);
		param.put("productNo", productNo);
		param.put("memberId", memberId);
		
		int result = productService.insertCart(param);
		
		return "redirect:/";
	}
	
	//CH
	@RequestMapping(value = "/productList.do",
					method = RequestMethod.GET)
	public String productList(Model model) {
		
		List<Product> list = productService.selectProductListAll();
		log.debug("list = {}", list);
		model.addAttribute("list", list);
		return "product/productList";
	}
	
	@RequestMapping("/searchProduct.do")
	public String searchProduct(String search, String category,Model model ) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		log.debug("search = {}",search);
		
		String[] cateArr = category.split(",");
		map.put("category", cateArr);
		
		log.debug("category = {}",category);
		log.debug("category = {}",category);
		
		
		map.put("search", search);
		map.put("category", category);
		
		List<Product> list = productService.searchProductList(map);
		
		model.addAttribute("list",list);
		
		return "product/productList";
	}
	
	@RequestMapping("/productCategory.do")
	public String productCategory(String category, Model model) {
		log.debug("category = {}",category);
		
		List<Product> list = productService.productCategory(category);
		
		model.addAttribute("list",list);
		model.addAttribute("category", category);
		
		return "product/productList";
	}
	
}
