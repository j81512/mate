package com.kh.mate.product.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.mate.product.model.service.ProductService;
import com.kh.mate.product.model.vo.Product;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/product")
@Slf4j
public class ProductController {

	@Autowired
	private ProductService productService;
	
	//JW
	
	@RequestMapping(value = "/productEnroll.do",
					method = RequestMethod.GET)
	public String productinsert() {
		
		return "/product/productEnroll";
	}
	
	@RequestMapping(value = "/productEnroll.do",
					method = RequestMethod.POST)
	public String productEnroll(Product product) {
		
		log.debug("product = {}", product);
		int result = productService.productEnroll(product);
		
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
	public String searchProduct(String type, String search, Model model ) {
		
		log.debug("type = {}",type);
		log.debug("search = {}",search);
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		map.put("type", type);
		map.put("search", search);
		
		List<Product> list = productService.searchProductList(map);
		
		model.addAttribute("list",list);
		
		return "product/productList";
	}
	
}
