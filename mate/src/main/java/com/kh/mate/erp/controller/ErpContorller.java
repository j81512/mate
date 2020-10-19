package com.kh.mate.erp.controller;

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
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.JsonObject;
import com.kh.mate.common.Utils;
import com.kh.mate.erp.model.service.ErpService;
import com.kh.mate.erp.model.vo.EMP;
<<<<<<< HEAD
=======
import com.kh.mate.erp.model.vo.EmpBoard;
>>>>>>> branch 'master' of https://github.com/j81512/mate.git
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

@SessionAttributes({"loginEmp"})
@Controller
public class ErpContorller {

	private static Logger log = LoggerFactory.getLogger(ErpContorller.class);
	
	@Autowired
	private ErpService erpService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@RequestMapping("/ERP/menu.do")
	public ModelAndView Menu(ModelAndView mav) {
		
		mav.setViewName("/ERP/menu");
		return mav;
	}
	
	@RequestMapping("/ERP/erpMain.do")
	public ModelAndView erpMain(ModelAndView mav) {
		
		mav.setViewName("/ERP/erpMain");
		return mav;
	}
	
	@RequestMapping("/ERP/ProductInfo.do")
	public ModelAndView productInfo(ModelAndView mav) {
		
		mav.setViewName("/ERP/ProductInfo");
		return mav;
	}
	
	@RequestMapping("/ERP/empInfoDetail.do")
	public String empInfoDetail(@RequestParam("empId") String empId, 
								Model model) {
		
		log.debug("empId ={} ", empId);
		EMP emp = erpService.selectOneEmp(empId);
		log.debug("emp = {}", emp);
		model.addAttribute("emp", emp);
		return "ERP/empInfoDetail";
	}
	
	@RequestMapping("/ERP/infoUpdate.do")
	public String infoUpdate(EMP emp, RedirectAttributes redirectAttr) {
		try {
			Map<String, Object>map = new HashMap<>();
			map.put("empId", emp.getEmpId());
			map.put("empPwd", emp.getEmpPwd());
			map.put("empName", emp.getEmpName());
			map.put("empAddr1", emp.getEmpAddr1());
			map.put("empAddr2", emp.getEmpAddr2());
			map.put("empAddr3", emp.getEmpAddr3());
			map.put("status", emp.getStatus());	
			
			int result = erpService.infoUpdate(map);
			log.debug("result ={}", result);
			log.debug("map={}", map);
			String msg = "정보수정 성공";
			redirectAttr.addFlashAttribute("msg", msg);
			
		}catch(Exception e) {
			String msg = "정보수정 실패";
			redirectAttr.addFlashAttribute("msg", msg);
		}
		return "redirect:/ERP/empManage.do";
	}
	
	@RequestMapping("/ERP/infoDelete.do")
	public String infoDelete(@RequestBody EMP emp, 
							 RedirectAttributes redirectAttr,
							 SessionStatus sessionStatus) {
		log.debug("emp = {}", emp);
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("empId", emp.getEmpId());
			map.put("empPwd", emp.getEmpPwd());
			
			int result = erpService.infoDelete(map);
			log.debug("result = {}", result);
			log.debug("map = {}", map);
			String msg = "삭제가 완료 되었습니다.";
			
			if(!sessionStatus.isComplete())
				sessionStatus.setComplete();
		}catch(Exception e) {
			String msg = "삭제 실패";
			redirectAttr.addFlashAttribute("msg", msg);
			log.error("error = {}", e);
		}
		return "redirect:/ERP/empManage.do";
	}
	

	@RequestMapping("/ERP/EmpBoardList.do")
	public String empBoardList(Model model) {
//		호근 empList.do가 게시판 가르킴  수정하겠음
		List<EMP> list = erpService.empList();
		List<Map<String, Object>> empBoardList = erpService.empBoardList();
		log.debug("list = {} ", list);
		log.debug("empBoardList = {} ", empBoardList);
		
		model.addAttribute("list", list);
		//model 추가함
		model.addAttribute("empBoardList", empBoardList);
		return "ERP/empList";
		
	}


	@RequestMapping("/ERP/empManage.do")
	public String empManage(Model model) {
		List<EMP> list = erpService.empList();
		
		log.debug("list = {} ", list);
		
		model.addAttribute("list", list);
		return "ERP/empManage";
	}
	
	@RequestMapping(value="/ERP/empList.do",
					method = RequestMethod.GET)
	public String empList(Model model) {
		
		List<EMP> list = erpService.empList();
		
		log.debug("list = {} ", list);
		
		model.addAttribute("list", list);
		return "ERP/empList";
		
	}
	
	@RequestMapping(value="/ERP/EmpEnroll.do",
					method= RequestMethod.GET)
	public ModelAndView EmpEnroll(ModelAndView mav) {
		
		mav.setViewName("ERP/EmpEnroll");
		return mav;
	}
	
	@RequestMapping(value="/ERP/EmpEnroll.do",
					method= RequestMethod.POST)
	public String EmpEnroll(RedirectAttributes redirectAttr,
							EMP emp) {
		
//		String rawPassword = emp.getEmpPwd();
		// 호근 암호화 처리 날림.
//		String encodedPassword = bcryptPasswordEncoder.encode(rawPassword);
//		emp.setEmpPwd(encodedPassword);
		
		log.debug("emp = " + emp);
		
		int result = erpService.insertEmp(emp);
		String msg = result > 0 ? "생성 성공" : "생성 실패";
		redirectAttr.addFlashAttribute("msg", msg);
		
		return "redirect:/";
	}
	
	@RequestMapping("/ERP/checkIdDuplicate.do")
	@ResponseBody
	public Map<String, Object> checkIdDuplicate(@RequestParam("empId") String empId){
		Map<String, Object> map = new HashMap<>();
		
		boolean isAvailable = erpService.selectOneEmp(empId) == null;
		
		map.put("empId", empId);
		map.put("isAvailable", isAvailable);
		
		return map;
	}
	
	@RequestMapping("/ERP/empInfoView.do")
	public String empInfoView(String empId, Model model) {
		model.addAttribute("emp", erpService.selectOneEmp(empId));
		log.debug("empId = {}", empId);
		return "ERP/empInfoView";
	}

	//김찬희 ERP 상품검색
	@RequestMapping("/ERP/searchInfo.do")
	public String searchInfo(String category, String search, String select,String upper, String lower, Model model) {
		
		log.debug(category);
		log.debug(search);
		log.debug("upper = {}", upper);
		log.debug("lower = {}", lower);
		
		log.debug("select = {}", select);
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		if(!upper.isEmpty() && upper != null) {
			int uNum = Integer.parseInt(upper);
			map.put("uNum", uNum);
			
		}
		if(!lower.isEmpty() && lower != null) {
			int lNum = Integer.parseInt(lower);
			map.put("lNum", lNum);
			
		}
		if(select.equals("product_no")) {
			int sNum = Integer.parseInt(search);
			log.debug("sNum = {}",sNum);
			map.put("sNum", sNum);
		}
		
		
		map.put("category", category);
		map.put("select", select);
		map.put("search", search);
		
		
		List<Product> list = erpService.searchInfo(map);
		
		log.debug("list = {}",list);
		
		model.addAttribute("list",list);
		
		return "/ERP/ProductInfo";
	}
	
	//김찬희 erp발주
	@RequestMapping("/ERP/orderERP.do")
	public String orderProduct(String eId, String pNo, Model model) {
		
		log.debug("productNo = {}", pNo);
		log.debug("empId = {}", eId);
		
		int productNo = Integer.parseInt(pNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("eId", eId);
		map.put("productNo", productNo);
		
		Product product = erpService.orderProduct(map);
		
		
		log.debug("product = {}",product);
		
		model.addAttribute("product",product);
		
		
		return "/ERP/productOrder";
	}
	
	@RequestMapping("/ERP/productOrder.do")
	public String productOrder(Product product) {
		
		log.debug("product = {}",product);
		
		int result = erpService.productOrder(product);
		
		return "/ERP/ProductInfo";
	}
	
	
	//김종완 상품등록

	//상품 등록 시 jsp연결
	@RequestMapping(value = "/ERP/productEnroll.do",
					method = RequestMethod.GET)
	public String productinsert(Model model) {
		
		List<EMP> list = erpService.empList();
		model.addAttribute("list", list);
		
		return "/ERP/productEnroll";
	}
	
	//상품 등록 submit버튼 클릭시 db저장
	@RequestMapping(value = "/ERP/productEnroll.do",
					method = RequestMethod.POST)
	public String productEnroll(Product product,
								@RequestParam("upFile") MultipartFile[] upFiles,
								HttpServletRequest request) throws IllegalStateException, IOException {
		
		//Content내 저장 폴더 명 변경
		String content = product.getContent();
		log.debug("content = {}", content);
		String repCont = content.replaceAll("temp", "images");
		log.debug("repCont = {}", repCont);
		product.setContent(repCont);
		
		//등록 시 업로드한 MainImages를 List로 가져오기
		List<ProductMainImages> mainImgList = new ArrayList<>();
		String saveDirectory = request.getServletContext().getRealPath("/resources/upload/mainimages");
		
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
		product.setPmiList(mainImgList);
		
		//Content에 Image파일이 있을 경우 (temp폴더내 파일이 저장되었을 경우)
		//productImage객체 생성 후 DB에 저장
		String tempDir = request.getServletContext().getRealPath("/resources/upload/temp");
		String imgDir = request.getServletContext().getRealPath("/resources/upload/images");
		File folder1 = new File(tempDir);
		File folder2 = new File(imgDir);
		
		List<String> productImages = new ArrayList<>();
		
		if(folder1.listFiles().length > 0) {
			log.debug("디버깅 확인용");
			productImages = Utils.getFileName(folder1);
			product.setProductImagesName(productImages);
		}
		
		log.debug("productImages@controller = {}", productImages);
		
		log.debug("product = {}", product);
		int result = erpService.productEnroll(product);
		
		//product입력 시, file입력 처리 -> DB에 image등록과 동시에 fileDir옮기기  
		if(result > 0) {
			Utils.fileCopy(folder1, folder2);
			Utils.fileDelete(folder1.toString());
		}else {
			Utils.fileDelete(folder1.toString());
		}
		
		return "redirect:/";
	}
	
	//뒤로가기 클릭 시 파일 삭제
	@RequestMapping(value = "/ERP/fileDelMethod.do",
					method = RequestMethod.GET)
	public String fileDelete(HttpServletRequest request) {
		//파일 삭제
		String tempDir = request.getServletContext().getRealPath("/resources/upload/temp");
		File folder1 = new File(tempDir);
		Utils.fileDelete(folder1.toString());
		
		return "redirect:/";
		
	}
	
	@RequestMapping(value = "/ERP/imageFileUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public String fileUpload(HttpServletRequest request, HttpServletResponse response,
							 MultipartHttpServletRequest multiFile) throws Exception {
		request.setCharacterEncoding("utf-8");
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");
		
		if(file != null) {
			if(file.getSize() > 0 ) {
				if(file.getContentType().toLowerCase().startsWith("image/")) {
					try {
						String fileName = Utils.getRenamedFileName(file.getOriginalFilename());
						byte[] bytes = file.getBytes();
						String uploadPath = request.getServletContext().getRealPath("/resources/upload/temp");
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()) {
							uploadFile.mkdirs();
						}
						//String renamedFilename = Utils.getRenamedFileName(fileName);
						//uploadPath = uploadPath + "/" + fileName;
						out = new FileOutputStream(new File(uploadPath, fileName));
						out.write(bytes);
						
						printWriter = response.getWriter();
						response.setContentType("text/html");
						String fileUrl = request.getContextPath() + "/resources/upload/temp/" + fileName;
						
						//json 데이터로 등록
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);
						
						printWriter.println(json);
						
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
	
	//jsp연결
	@RequestMapping(value = "/ERP/productUpdate.do",
					method = RequestMethod.GET)
	public String productUpdate(@RequestParam("productNo") String productNo,
							  Model model) {
		
		Product product = erpService.selectProductOne(productNo);
		
		List<ProductMainImages> list = erpService.selectProductMainImages(productNo);
		model.addAttribute("product", product);
		model.addAttribute("list", list);
		
		return "ERP/productUpdate";
	}
	
	//수정
	@RequestMapping(value = "/ERP/productUpdate.do",
					method = RequestMethod.POST)
	public String productUpdate(Product product, 
								@RequestParam("upFile") MultipartFile[] upFiles, 
								@RequestParam("fileChange") int fileChange,
								@RequestParam("productImageNo") String[] productImageNos,
								HttpServletRequest request) throws IllegalStateException, IOException {
		//Content내 저장 폴더 명 변경
		String content = product.getContent();
		log.debug("content = {}", content);
		String repCont = content.replaceAll("temp", "images");
		log.debug("repCont = {}", repCont);
		product.setContent(repCont);
		
		
		//fileChange값이 1이면 섬네일 이미지 수정감지 
		log.debug("fileChange = {}", fileChange);
		if(fileChange > 0) {
			List<ProductMainImages> storedMainImgs 
				= erpService.selectProductMainImages(String.valueOf(product.getProductNo()));
			String mainDirectory = request.getServletContext()
										  .getRealPath("/resources/upload/mainimages/");
			
				//저장된 파일 삭제
				for(ProductMainImages smi : storedMainImgs) {
					boolean result = new File(mainDirectory, smi.getRenamedFilename()).delete();
					log.debug("result = {}", result);
				}
			
			//새로 넘어온 파일 저장
			List<ProductMainImages> mainImgList = new ArrayList<>();
			
				for(MultipartFile upFile : upFiles) {
					String renamedFilename = Utils.getRenamedFileName(upFile.getOriginalFilename());
					
					File dest = new File(mainDirectory, renamedFilename);
					upFile.transferTo(dest);
					
					ProductMainImages newMainImgs = new ProductMainImages();
					newMainImgs.setOriginalFilename(upFile.getOriginalFilename());
					newMainImgs.setRenamedFilename(renamedFilename);
					newMainImgs.setProductNo(product.getProductNo());
					mainImgList.add(newMainImgs);
			
				}
				
			product.setPmiList(mainImgList);
			
		}
		
		String tempDir = request.getServletContext().getRealPath("/resources/upload/temp");
		String imgDir = request.getServletContext().getRealPath("/resources/upload/images");
		File folder1 = new File(tempDir);
		File folder2 = new File(imgDir);
		
		if(folder1.listFiles().length > 0) {
			List<String> productImages = Utils.getFileName(folder1);
			log.debug("productImages = {}",productImages);
			product.setProductImagesName(productImages);
		}
		
		log.debug("product = {}", product);
		int result = erpService.productUpdate(product);
		
		//product입력 시, file입력 처리 -> DB에 image등록과 동시에 fileDir옮기기  
		if(result > 0) {
			Utils.fileCopy(folder1, folder2);
			Utils.fileDelete(folder1.toString());
		}else {
			Utils.fileDelete(folder1.toString());
		}
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "/ERP/productDelete.do",
					method = RequestMethod.POST)
	public String productDelete(@RequestParam("productNo") String productNo,
								HttpServletRequest request) {
		
		List<ProductMainImages> pmis = erpService.selectProductMainImages(productNo);
		List<ProductImages> pis = erpService.selectProductImages(productNo);
		String mainDir = request.getServletContext().getRealPath("/resources/upload/mainimages");
		String imgDir = request.getServletContext().getRealPath("/resources/upload/images");
		
		int result = erpService.productDelete(productNo);
		
		log.debug("result@controller = {}", result);
		
		if(result > 0) {
			//폴더 내 파일 모두 삭제 
			boolean flag = false;
			for(ProductMainImages p : pmis) {
				flag = new File(mainDir, p.getRenamedFilename()).delete();
			}
			for(ProductImages pp : pis) {
				flag = new File(imgDir, pp.getRenamedFilename()).delete();
			}
			log.debug("flag,result = {}, {}",flag,result);
		}
		
		return "ERP/ProductInfo";
	}
	
	// 호근 관리자 로그인 및 로그인 세션 추가 
	@PostMapping("/ERP/erpLogin.do")
	public String memberLogin(@RequestParam("empId") String empId
			  ,@RequestParam("empPwd") String empPwd
			  ,@RequestParam("status") int status
			  ,RedirectAttributes redirectAttr
			  ,Model model
			  ,HttpSession session) {
		log.debug("empId = {}", empId);
		log.debug("empPwd ={}", empPwd);
		log.debug("status ={}", status);

		EMP loginEmp = erpService.selectOneEmp(empId);
		
		log.debug("loginEmp = {}", loginEmp);
		String location = "/";
		
		if(	loginEmp != null && (loginEmp.getEmpId().equals(empId))
				&& (loginEmp.getEmpPwd().equals(empPwd))
				&& (loginEmp.getStatus() == status )) {
			model.addAttribute("loginEmp", loginEmp);
	
		}

		return "redirect:/ERP/menu.do";
	}
	@RequestMapping("/ERP/logout.do")
	public String empLogout(SessionStatus sessionStatus) {
		if(!sessionStatus.isComplete()) {
			sessionStatus.setComplete();
			
		}
		return "redirect:/";
	}
	
	@RequestMapping("/ERP/EmpBoardEnroll.do")
	public void EmpboardEnroll() {
			
	}
	
	@RequestMapping("/ERP/EmpBoardDetail.do")
	public ModelAndView boardDetail(@RequestParam("no") int no,
									ModelAndView mav) {
		log.debug("no = {}", no);
	    EmpBoard empBoard = erpService.selectOneEmpBoard(no);
		mav.addObject("empBoard", empBoard);
//		model.addAttribute("board", boardList);
		mav.setViewName("ERP/EmpBoardDetail");
		 return mav;
	}
}
