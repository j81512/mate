package com.kh.mate.product.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mate.member.model.vo.Member;
import com.kh.mate.product.model.service.ProductService;
import com.kh.mate.product.model.vo.Cart;
import com.kh.mate.product.model.vo.Product;
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
							@RequestParam("memberId") String memberId,
							HttpServletRequest request,
							Model model,
							RedirectAttributes redirectAttribute){
		
		log.debug("amount = {}",amount);
		log.debug("productNo={}",productNo);
		Map<String, Object> param = new HashMap<>();
		param.put("amount", amount);
		param.put("productNo", productNo);
		param.put("memberId", memberId);
		
		int result = productService.insertCart(param);
		log.debug("result = {}", result);
		
		if(result > 0) {
			redirectAttribute.addFlashAttribute("msg", "장바구니 저장 성공");
		}else {
			redirectAttribute.addFlashAttribute("msg", "장바구니 저장 실패");
		}
		
		String redUrl = "product/productDetail.do?productNo="+productNo;
		return "redirect:/" + redUrl;
	}
	
	@RequestMapping("/selectCart.do")
	public String selectCart (@RequestParam("memberId") String memberId,
							  Model model) {
		
		List<Map<String, Object>> cart = productService.selectCartList(memberId);
		log.debug("cart = {}", cart);
		Map<String, Object> temp = new HashMap<>();
		for(int i = 0; i < cart.size(); i++) {
			temp.put(String.valueOf(i), cart.get(i));
		}
		log.debug("temp = {}", temp);
		
		Cart c = (Cart)temp.get("0");
		log.debug("c = {}", c);
//		String productNo = String.valueOf(temp.get("productNo"));
//		log.debug("productNo = {}",productNo);
		
		List<ProductMainImages> pmi = new ArrayList<>();
		if(cart != null) {
			pmi = productService.selectProductMainImages(String.valueOf(c.getProductNo()));
			log.debug("pmi = {}", pmi);
		}
		
		model.addAttribute("pmi", pmi);
		model.addAttribute("cart", cart);
		return "product/cartView";
	}
	
	@RequestMapping("/deleteFromCart.do")
	public String deleteFromCart(@RequestParam("productNo") String prodctNo,
								 HttpSession session,
								 Model model) {
		Member loginMember = (Member) session.getAttribute("loginMember");
		String memberId = loginMember.getMemberId();
		Map<String, Object> param = new HashMap<>();
		param.put("productNo", prodctNo);
		param.put("memberId", memberId);
		
		int result = productService.deleteFromCart(param);
		
		if(result > 0) {
			model.addAttribute("msg", "장바구니에서 상품이 제거되었습니다.");
		}else {
			model.addAttribute("msg", "상품 제거에 실패하였습니다. 다시 시도하여주세요.");
		}
		return "product/cartView";
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
