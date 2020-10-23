package com.kh.mate.erp.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.kh.mate.erp.model.dao.ErpDAO;
import com.kh.mate.erp.model.vo.EMP;
import com.kh.mate.erp.model.vo.EmpBoard;
import com.kh.mate.erp.model.vo.EmpBoardImage;
import com.kh.mate.erp.model.vo.EmpBoardReply;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class ErpServiceImpl implements ErpService {

	@Autowired
	private ErpDAO erpDAO;

	@Override
	public int insertEmp(EMP emp) {
		return erpDAO.insertEmp(emp);
	}

	@Override
	public EMP selectOneEmp(String empId) {
		return erpDAO.selectOneEmp(empId);
	}

	@Override
	public int infoUpdate(Map<String, Object> map) {
		return erpDAO.infoUpdate(map);
	}

	@Override
	public int infoDelete(Map<String, Object> map) {
		return erpDAO.infoDelete(map);
	}

	@Override
	public List<Product> searchInfo(Map<String, Object> map) {
		return erpDAO.searchInfo(map);
	}
	
	@Override
	public List<EMP> empList() {
		return erpDAO.empList();
	}

	@Override
	public Product orderProduct(Map<String, Object> map) {
		
		Product product = erpDAO.orderProduct(map);
		
//		product.setEId(erpDAO.findEmpid(product.getProductNo()));
		
		return product;
	}
	
	
	@Override
	public int productOrder(Product product) {
		return erpDAO.productOrder(product);
	}
	
	
	//김종완


	@Override
	public int productEnroll(Product product) {
		
		int result = erpDAO.productEnroll(product);
		
		//MainImages가 추가되어있다면 실행될 메소드
		if(product.getPmiList() != null) {
			for(ProductMainImages mainImg : product.getPmiList()) {
				
				mainImg.setProductNo(product.getProductNo());
				result = erpDAO.productMainImagesEnroll(mainImg);
			}
		}

		//ImagesName도 추가
		if(product.getProductImagesName() != null) {
			List<String> imagesName = product.getProductImagesName();
			String str = "";
			for(int i = 0; i < imagesName.size(); i++) {
				str += imagesName.get(i);
				if(i != (imagesName.size() - 1)) {
					str += ",";
				}
			}
			log.debug("str = {}", str);
			
		ProductImages pigs = new ProductImages(0, str, product.getProductNo());
		result = erpDAO.productImageEnroll(pigs);
		}
		
		return result;
	}

	@Override
	public Product selectProductOne(String productNo) {
		return erpDAO.selectProductOne(productNo);
	}

	@Override
	public List<ProductMainImages> selectProductMainImages(String productNo) {
		return erpDAO.selectProductMainImages(productNo);
	}

	@Override
	public List<ProductImages> selectProductImages(String productNo) {
		return erpDAO.selectProductImages(productNo);
	}
	
	@Override
	public int productUpdate(Product product) {
		int result = erpDAO.productUpdate(product);
		
		//productMainImage 수정 여부 확인 후 진행
		if(result > 0 && product.getPmiList() != null) {
			//기존 섬네일 이미지 삭제
			result = erpDAO.productMainImagesDelete(String.valueOf(product.getProductNo()));
			//업데이트된 이미지 새로 등록
			for(ProductMainImages mainImg : product.getPmiList()) {
				mainImg.setProductNo(product.getProductNo());
				result = erpDAO.productMainImagesEnroll(mainImg);
			}
			
		}
		
		//productImage 수정 여부 확인 후 진행
		if(product.getProductImagesName() != null) {
			List<String> imagesName = product.getProductImagesName();
			String str = "";
			for(int i = 0; i < imagesName.size(); i++) {
				str += imagesName.get(i);
				if(i != (imagesName.size() - 1)) {
					str += ",";
				}
			}
			log.debug("str = {}", str);
			
		ProductImages pigs = new ProductImages(0, str, product.getProductNo());
		result = erpDAO.productImageEnroll(pigs);
		}
		
		log.debug("result@service = {}", result);
		return result;
	}

	@Override
	public int productDelete(String productNo) {
		//productTable 데이터 삭제
		int result = 0;
		
		result = erpDAO.productDelete(productNo);
		log.debug("result@service1 = {}", result);
		
		
		return result;
	}

	//호근 emp 게시판 추가

	@Override
	public EmpBoard selectOneEmpBoard(int no, boolean hasRead) {
		int result = 0;
		if(hasRead == false) {
			result = erpDAO.increaseReadCount(no);
		}
		
		return erpDAO.selectOneEmpBoard(no);
	}

	@Override
	public List<EmpBoardReply> replyList(int boardNo) {
		return erpDAO.replyList(boardNo);
	}

	@Override
	public int boardReply(EmpBoardReply boardReply) {
		return erpDAO.boardReply(boardReply);
	}

	@Override
	public int deleteReply(int boardReplyNo) {
		return erpDAO.deleteReply(boardReplyNo);
	}

	@Override
	public int updateReply(Map<String, Object> map) {
	
		return erpDAO.updateReply(map);
	}

	@Override
	public int insertEmpBoard(EmpBoard empBoard) {
		int result = erpDAO.inserEmpBoard(empBoard);
		

		if(empBoard.getEmpBoardImageList() != null) {
			
			for(EmpBoardImage empBoardImage : empBoard.getEmpBoardImageList()) {
				
				empBoardImage.setBoardNo(empBoard.getBoardNo());
				result = erpDAO.inserEmpBoardImage(empBoardImage);
				
			}
		
		}
		
		if(empBoard.getCategory().equals("req")) {
			log.debug("호출은 되냐?");
			empBoard.setBoardNo(empBoard.getBoardNo());
			result = erpDAO.insertRequestStock(empBoard);
	
			
		}
		return result;
	}

	@Override
	public EmpBoardImage empBoardFileDownload(int boardImageNo) {
		return erpDAO.empBoardFileDownload(boardImageNo);
	}

	@Override
	public List<Product> erpProductList() {
		return erpDAO.erpProductList();
	}


	@Override
	public List<EmpBoard> searchBoard(String searchType, String searchKeyword, int cPage, int numPerPage) {
		return erpDAO.searchBoard(searchType, searchKeyword,cPage,numPerPage);
	}

	@Override
	public int getSearchContents(Map<String, String> map) {
		
		int totalContents = erpDAO.getSearchContents(map);
		
		return totalContents;
	}

	
}
