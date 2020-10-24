package com.kh.mate.product.controller;


import static com.kh.mate.common.Utils.getRenamedFileName;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mate.common.paging.PagingVo;
import com.kh.mate.member.model.vo.Address;
import com.kh.mate.member.model.vo.Member;
import com.kh.mate.product.model.service.ProductService;
import com.kh.mate.product.model.vo.Cart;
import com.kh.mate.product.model.vo.Product;

import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

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
	
	@PostMapping("/saveCart.do")
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
		
		List<Cart> cart = productService.selectCartList(memberId);
		log.debug("cart = {}", cart);

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
		return "redirect:/product/selectCart.do?memberId=" + memberId;
	}
	
	
	//단일 상품 구매 페이지 상품 전달
	@PostMapping("/purchaseProduct.do")
	public String purchaseProduct (@RequestParam("amount") String amount,
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
			redirectAttribute.addFlashAttribute("msg", "결제를 진행해 주세요.");
		}else {
			redirectAttribute.addFlashAttribute("msg", "결제오류...");
		}
		
		return "redirect:/product/selectCart.do?memberId=" + memberId;
	}
	
	
	//CH
	@RequestMapping(value = "/productList.do",
					method = RequestMethod.GET)
	public String productList(Model model,PagingVo page,String nowPage, String cntPerPage) {
		
		int total = productService.countProduct(); 
		
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage="5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}

		page = new PagingVo(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		
		List<Product> list = productService.selectProductListAll(page);
		log.debug("list = {}", list);
		model.addAttribute("page",page);
		model.addAttribute("list", list);
		return "product/productList";
	}
	
	@RequestMapping("/searchProduct.do")
	public String searchProduct(String search, String category, PagingVo page,String nowPage, String cntPerPage ,Model model ) {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		int total = productService.countProduct(); 
		log.debug("nowPage = {}",nowPage);
		log.debug("cntPerPage = {}",cntPerPage);
		log.debug("total = {}",total);
		
		if(nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage="5";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "5";
		}
		
		page = new PagingVo(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		log.debug("page = {}",page);
		
		map.put("page", page);
		
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
		
		model.addAttribute("page",page);
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
	
	@ResponseBody
	@PostMapping("/purchaseConfirm.do")
	public Map<String, Object> purchaseConfirm(@RequestParam("purchaseLogNo") int purchaseLogNo){
		
		Map<String, Object> map = new HashMap<>();
		
		int result = productService.updatePurchaseConfirm(purchaseLogNo);
		
		map.put("result", result);
		
		return map;
	}
	
	@ResponseBody
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
		log.debug("file@Controller = {}",file);
		File newFile = null;
		if(file != null && !file.isEmpty()) {
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
	
	@ResponseBody
	@PostMapping("/purchaseProducts.do")
	public Map<String, Object> purchaseProducts(@RequestParam("jsonParam") String jsonParam) {
		
		JSONArray array = JSONArray.fromObject(jsonParam);
		
		List<Map<String, Object>> params = new ArrayList<>();
		
		for(int i = 0; i < array.size(); i++) {
			JSONObject jObj = (JSONObject)array.get(i);
			Map<String, Object> map = new HashMap<>();
			map.put("addressName", jObj.get("addressName"));
			map.put("productNo", jObj.get("productNo"));
			map.put("amount", jObj.get("amount"));
			map.put("memberId", jObj.get("memberId"));
			
			params.add(map);
		}
		
		log.debug("params@controller = {}", params);
		
		int result = productService.purchaseProducts(params);
		
		Map<String, Object> map = new HashMap<>();
		map.put("result", result);
		map.put("purchaseNo", params.get(0).get("purchaseNo"));
		
		return map;
	}
}
