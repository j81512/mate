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
	
	//상품 등록 시 jsp연결
	@RequestMapping(value = "/productEnroll.do",
					method = RequestMethod.GET)
	public String productinsert() {
		
		return "/product/productEnroll";
	}
	
	//상품 등록 submit버튼 클릭시 db저장
	@RequestMapping(value = "/productEnroll.do",
					method = RequestMethod.POST)
	public String productEnroll(Product product,
								@RequestParam("upFile") MultipartFile[] upFiles,
								HttpServletRequest requset) throws IllegalStateException, IOException {
		
		
		//등록 시 업로드한 MainImages를 List로 가져오기
		List<ProductMainImages> mainImgList = new ArrayList<>();
		String saveDirectory = requset.getServletContext().getRealPath("/resources/upload/mainimages");
		
			for(MultipartFile upFile : upFiles) {
				
				//파일을 선택하지 않고 전송한 경우
				if(upFile.isEmpty()) {
					//섬네일 이미지는 반드시 필요하기 때문에 제출하지 않은 경우 에러넘겨줘야됨.
				}
				//파일을 첨부하고 전송한 경우 
				else {
					//1.1  파일명(renamdFilename) 생성
					String renamedFilename = Utils.getRenamedFileName(upFile.getOriginalFilename());
					
					//1.2 메모리(RAM)에 저장되어있는 파일 -> 서버 컴퓨터 디렉토리 저장 tranferTo
					File dest = new File(saveDirectory, renamedFilename);
					upFile.transferTo(dest);
					
					//1.3 ProductMainImages객체 생성
					ProductMainImages mainImgs = new ProductMainImages();
					mainImgs.setOriginalFilename(upFile.getOriginalFilename());
					mainImgs.setRenamedFilename(renamedFilename);
					mainImgList.add(mainImgs);
					
				}
				
			}
		
		//Product객체에 MainImages객체를 Setting
		log.debug("mainImgList = {}", mainImgList);	
		product.setProductMainImages(mainImgList);
		
		log.debug("product = {}", product);
		int result = productService.productEnroll(product);
		
		return "redirect:/";
	}
	
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
	
	@RequestMapping(value = "/imageFileUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public String fileUpload(HttpServletRequest request, HttpServletResponse response,
							 MultipartHttpServletRequest multiFile) throws Exception {
		
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");
		ProductImages productImage = null;
		
		if(file != null) {
			if(file.getSize() > 0 ) {
				if(file.getContentType().toLowerCase().startsWith("image/")) {
					try {
						productImage = new ProductImages();
						String fileName = file.getOriginalFilename();
						productImage.setOriginalFilename(fileName);
						byte[] bytes = file.getBytes();
						String uploadPath = request.getServletContext().getRealPath("/resources/upload/images");
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()) {
							uploadFile.mkdirs();
						}
						String renamedFilename = Utils.getRenamedFileName(fileName);
						productImage.setRenamedFilename(renamedFilename);
						//uploadPath = uploadPath + "/" + fileName;
						out = new FileOutputStream(new File(uploadPath, renamedFilename));
						out.write(bytes);
						
						printWriter = response.getWriter();
						response.setContentType("text/html");
						String fileUrl = request.getContextPath() + "/resources/upload/images/" + renamedFilename;
						
						//json 데이터로 등록
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", renamedFilename);
						json.addProperty("url", fileUrl);
						
						printWriter.println(json);
						
						//DB에 저장 -> 저장결과에 따라서 분기처리
						productService.productImageEnroll(productImage);
						
						
					} catch(IOException e) {
						e.printStackTrace();
					} finally {
						if(out != null)
							out.close();
						if(printWriter != null)
							printWriter.close();
					}
				}
			}
		}
		
		return null;
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
	public String searchProduct(String type, String search, String category,Model model ) {
		
		log.debug("type = {}",type);
		log.debug("search = {}",search);
		log.debug("category = {}",category);
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		map.put("type", type);
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
