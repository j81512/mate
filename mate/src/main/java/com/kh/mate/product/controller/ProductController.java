package com.kh.mate.product.controller;


import static com.kh.mate.common.Utils.getRenamedFileName;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.mate.member.model.vo.Address;
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
		
		List<Cart> cart = productService.selectCartList(memberId);
		log.debug("cart = {}", cart);
//		Map<String, Object> temp = new HashMap<>();
//		for(int i = 0; i < cart.size(); i++) {
//			temp.put(String.valueOf(i), cart.get(i));
//		}
//		log.debug("temp = {}", temp);
//		
//		Cart c = (Cart)temp.get("0");
//		log.debug("c = {}", c);
//		String productNo = String.valueOf(temp.get("productNo"));
//		log.debug("productNo = {}",productNo);
		
//		List<ProductMainImages> pmi = new ArrayList<>();
//		if(cart != null) {
//			pmi = productService.selectProductMainImages(String.valueOf(c.getProductNo()));
//			log.debug("pmi = {}", pmi);
//		}
//		
//		model.addAttribute("pmi", pmi);
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
	
	
	//구매 페이지 단순 우회
	@RequestMapping("/purchaseProduct.do")
	public String purchaseProductOne(@RequestParam("memberId") String memberId,
									Model model) {
		//로그인 아이디로 입력된 배송지 정보만 전달
		List<Address> memAddr = productService.selectAddressList(memberId);
		Address[] addrArr = new Address[memAddr.size()];
		if(!memAddr.isEmpty()) {
			//최근 입력된 배송지 정보 저장
			for(int i=0; i<memAddr.size(); i++) {
				addrArr[i] = memAddr.get(i);
			}
			// 전송준비
			log.debug("addrArr = {}", addrArr);
			model.addAttribute("recentAddr", addrArr[0]);
		}
		return "product/purchaseProduct";
	}
	
	
	//단일 상품 구매 페이지 상품 전달
	@RequestMapping(value = "/purchaseProduct.do",
					method = RequestMethod.POST)
	public String purchaseProductOne(@RequestParam("productNo") String productNo,
								  @RequestParam("memberId") String memberId,
								  @RequestParam("amount") String amount,
								  Model model) {
		//0. 로그인 아이디로 입력된 배송지정보 받아오기
		List<Address> memAddr = productService.selectAddressList(memberId);
		Address[] addrArr = new Address[memAddr.size()];
		//0.1 배송지 정보 유무 여부로 분기 처리 
		if(!memAddr.isEmpty()) {
			//0.2 최근 입력된 배송지 정보 저장
			for(int i=0; i<memAddr.size(); i++) {
				addrArr[i] = memAddr.get(i);
			}
			//0.3 전송준비
			log.debug("addrArr = {}", addrArr);
			model.addAttribute("recentAddr", addrArr[0]);
		}
		
		//1. 로그인 아이디로 입력된 장바구니 정보 받아오기
		List<Cart> cartList = productService.selectCartList(memberId);
		//1.1 장바구니 입력 유무로 분기 처리
		if(!cartList.isEmpty()) {
			//1.2 장바구니 입력된 상품정보가 있다면 전송 준비
			model.addAttribute("cartList", cartList);
		}
		
			//2.2 단일 상품 구매건에 대해서도 추가
			Product purProduct = productService.selectProductOne(productNo);
			model.addAttribute("purProduct", purProduct);
			model.addAttribute("amount", amount);
		
		return "product/purchaseProduct";
	}
	
	
	//상품 구매목록 전체 삭제 버튼 클릭 시
	@RequestMapping("deleteCartAll.do")
	public String deleteCartAll(@RequestParam("memberId")String memberId,
								RedirectAttributes redirectAttr) {
		
		//장바구니 목록 전체 삭제 후
		log.debug("memberId={}",memberId);
		
		//비어있는 구매 목록 화면으로 리 다이렉트
		return "redirect:/product/purchaseProduct.do?memberId="+memberId;
	}
	
	//결제버튼 입력 시
	@RequestMapping("/productPayment.do")
	public String productPayment(@RequestParam("memberId") String memberId,
								 @RequestParam("productNo") String[] productNos,
								 @RequestParam("amount") String[] amounts) {
		
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
