package com.kh.mate.product.controller;

import static com.kh.mate.common.Utils.getRenamedFileName;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@RequestMapping("/selectCart.do")
	public String selectCart (@RequestParam("memberId") String memberId,
							  Model model) {
		
		List<Map<String, Object>> cart = productService.selectCartList(memberId);
		log.debug("cart = {}", cart);
		
		model.addAttribute("cart",cart);
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
		
		if(!category.isEmpty()) {
			String[] cateArr = category.split(",");
			map.put("cateArr", cateArr);
			log.debug("cateArr = {}",cateArr);
			map.put("category", category);
			log.debug("category = {}",category);
			
		}
		
		
		
		
		map.put("search", search);
		
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
	
	
	//jh
	@PostMapping("/insertReview.do")
	public String insertReview(RedirectAttributes redirectAttr,
							 @RequestParam("purchaseLogNo") int purchaseLogNo,
							 @RequestParam("comments") String comments,
							 @RequestParam("score") int score) {
		
		Map<String, Object> param = new HashMap<>();
		param.put("purchaseLogNo", purchaseLogNo);
		param.put("comments", comments);
		param.put("score", score);
		
		log.debug("param@Controller = {}", param);
		int result = productService.insertReview(param);
		String msg = "";
		if(result > 0) msg = "리뷰를 등록해 주셔서 감사합니다.";
		else msg = "리뷰 등록에 실패하셨습니다. 다시 시도해주세요.";
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/member/myPage.do";
	}
	
	@PostMapping("/purchaseConfirm.do")
	public int purchaseConfirm(@RequestParam("purchaseLogNo") int purchaseLogNo){
		
		int result = productService.updatePurchaseConfirm(purchaseLogNo);
		
		return result;
	}
	
	@PostMapping("/return.do")
	public int returnProduct(@RequestParam("purchaseLogNo") int purchaseLogNo,
							 @RequestParam("status") String status,
							 @RequestParam("content") String content,
							 @RequestParam("amount") int amount,
							 @RequestParam(value = "file", required = false) MultipartFile file,
							 HttpServletRequest request) throws IllegalStateException, IOException {

		Map<String, Object> param = new HashMap<>();
		param.put("purchaseLogNo", purchaseLogNo);
		param.put("status", status);
		param.put("content", content);
		param.put("amount", amount);
		
		File newFile = null;
		if(!file.isEmpty() && file != null) {
			param.put("originalFilename", file.getOriginalFilename());
			String renamedFilename = getRenamedFileName(file.getOriginalFilename());
			param.put("renamedFilename", renamedFilename);
			
			String saveDirectory = request.getServletContext().getRealPath("/resources/upload/return");
			newFile = new File(saveDirectory, renamedFilename);
			file.transferTo(newFile);
		}
		
		int result = productService.insertReturn(param);
		
		if(result <= 0) {
			newFile.delete();
		}
		
		return result;	
	}
}
