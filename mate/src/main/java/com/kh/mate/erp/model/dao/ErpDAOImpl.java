package com.kh.mate.erp.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mate.erp.model.vo.EMP;
import com.kh.mate.erp.model.vo.EmpBoard;
import com.kh.mate.erp.model.vo.EmpBoardImage;
import com.kh.mate.erp.model.vo.EmpBoardReply;
import com.kh.mate.log.vo.IoLog;
import com.kh.mate.log.vo.Receive;
import com.kh.mate.log.vo.RequestLog;
import com.kh.mate.product.model.vo.Product;
import com.kh.mate.product.model.vo.ProductImages;
import com.kh.mate.product.model.vo.ProductMainImages;

@Repository
public class ErpDAOImpl implements ErpDAO {


	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public EMP selectOneEmp(String empId) {
		return sqlSession.selectOne("emp.selectOneEmp", empId);
	}

	@Override
	public int insertEmp(EMP emp) {
		return sqlSession.insert("emp.insertEmp", emp);
	}

	@Override
	public int infoUpdate(EMP emp) {
		return sqlSession.update("emp.infoUpdate", emp);
	}

	@Override
	public int infoDelete(Map<String, Object> map) {
		return sqlSession.delete("emp.infoDelete", map);
	}

	@Override
	public List<Product> searchInfo(Map<String, Object> map) {
		return sqlSession.selectList("erp.searchInfo",map);
	}
	
	@Override
		public List<EMP> empList() {
			return sqlSession.selectList("emp.empList");
		}
	@Override
	public List<IoLog> ioLogList() {
		return sqlSession.selectList("emp.ioLogList");
	}

	@Override
	public List<Product> productList() {
		return sqlSession.selectList("emp.productList");
	}

	@Override
	public List<Receive> receiveList() {
		return sqlSession.selectList("emp.receiveList");
	}

	@Override
	public List<RequestLog> requestList() {
		return sqlSession.selectList("emp.requestList");
	}

	@Override
	public Product orderProduct(Map<String, Object> map) {
		return sqlSession.selectOne("erp.orderProduct",map);
	}
	
	@Override
	public String findEmpid(int productNo) {
		return sqlSession.selectOne("erp.findEmpid",productNo);
	}

	
	
	@Override
	public int productOrder(Product product) {
		return sqlSession.insert("erp.productOrder",product);
	}
	

  
  //김종완

	@Override
	public int productEnroll(Product product) {
		return sqlSession.insert("erp.productEnroll", product);
	}

	@Override
	public int productImageEnroll(ProductImages pigs) {
		return sqlSession.insert("erp.productImageEnroll", pigs);
	}

	@Override
	public Product selectProductOne(String productNo) {
		return sqlSession.selectOne("erp.selectProductOne", productNo);
	}

	@Override
	public List<ProductMainImages> selectProductMainImages(String productNo) {
		return sqlSession.selectList("erp.selectProductMainImages", productNo);
	}
	
	@Override
	public List<ProductImages> selectProductImages(String productNo) {
		return sqlSession.selectList("erp.selectProductImages", productNo);
	}

	@Override
	public int productMainImagesEnroll(ProductMainImages mainImg) {
		return sqlSession.insert("erp.productMainImagesEnroll", mainImg);
	}

	@Override
	public int productUpdate(Product product) {
		return sqlSession.update("erp.productUpdate", product);
	}

	@Override
	public int productMainImagesDelete(String productNo) {
		return sqlSession.delete("erp.productMainImagesDelete", productNo);
	}

	@Override
	public int productDelete(String productNo) {
		return sqlSession.delete("erp.productDelete", productNo);
	}


	@Override
	public int productImagesDelete(String productNo) {
		return sqlSession.delete("erp.productImagesDelete", productNo);
	}

	@Override
	public List<RequestLog> selectRequsestList(String empId) {
		return sqlSession.selectList("erp.selectRequsestList", empId);
	}
	
	@Override
	public int updateRequestToApp(int requestNo) {
		return sqlSession.update("erp.updateRequestToApp", requestNo);
	}

	@Override
	public int updateRequestToRef(int requestNo) {
		return sqlSession.update("erp.updateRequestToRef", requestNo);
	}
	
	@Override
	public List<Receive> selectReceiveList(String empId) {
		return sqlSession.selectList("erp.selectReceiveList", empId);
	}
	
	@Override
	public int updateReceiveToApp(int receiveNo) {
		return sqlSession.update("erp.updateReceiveToApp", receiveNo);
	}
	
	@Override
	public int updateReceiveToRef(int receiveNo) {
		return sqlSession.update("erp.updateReceiveToRef", receiveNo);
	}
	
	//호근 추가


	

	@Override
	public EmpBoard selectOneEmpBoard(int no) {
		return sqlSession.selectOne("erpBoard.selectOneEmpBoard",no);
	}

	@Override
	public List<EmpBoardReply> replyList(int boardNo) {
		return sqlSession.selectList("erpBoard.selectReplyList", boardNo);
	}

	@Override
	public int boardReply(EmpBoardReply boardReply) {
		return sqlSession.insert("erpBoard.insertBoardReply", boardReply);
	}

	@Override
	public int deleteReply(int boardReplyNo) {
		return sqlSession.delete("erpBoard.deleteReply", boardReplyNo);
	}

	@Override
	public int updateReply(Map<String, Object> map) {
		return sqlSession.update("erpBoard.updateReply", map);
	}

	@Override
	public int inserEmpBoard(EmpBoard empBoard) {
		return sqlSession.insert("erpBoard.insertEmpBoard", empBoard);
	}

	@Override
	public int inserEmpBoardImage(EmpBoardImage empBoardImage) {
		return sqlSession.insert("erpBoard.insertEmpBoardImage", empBoardImage);
	}

	@Override
	public EmpBoardImage empBoardFileDownload(int boardImageNo) {
		return sqlSession.selectOne("erpBoard.empBoardFileDownload", boardImageNo);
	}

	@Override
	public List<Product> erpProductList() {
		return sqlSession.selectList("erpBoard.erpProductList");
	}

	@Override
	public int insertRequestStock(EmpBoard empBoard) {
		return sqlSession.insert("erpBoard.insertRequestStock", empBoard);
	}

	@Override
	public int increaseReadCount(int no) {
		return sqlSession.update("erpBoard.increaseReadCount", no);
	}


	@Override
	public List<EmpBoard> searchBoard(String searchType, String searchKeyword, int cPage, int numPerPage) {
		Map<String, Object> map = new HashMap<>();
		
		map.put("cPage", ((cPage-1)*numPerPage+1));
		map.put("numPerPage", (cPage * numPerPage));
		map.put("searchType", searchType);
		map.put("searchKeyword", searchKeyword);
		
		return sqlSession.selectList("erpBoard.searchBoard", map);
	}

	@Override
	public int getSearchContents(Map<String, String> map) {
		return sqlSession.selectOne("erpBoard.searchContents", map);
	}
	
	//김찬희 페이징작업
	@Override
	public int countProduct(EMP emp) {
		return sqlSession.selectOne("erp.countProduct",emp);
	}
	//누락상품검사
	
	@Override
	public List<Product> selectAll() {
		return sqlSession.selectList("erp.selectAll");
	}

	@Override
	public List<Integer> productCompare(EMP emp) {
		return sqlSession.selectList("erp.productCompare",emp);
	}

	//누락재고상품추가
	@Override
	public int mStockInsert(Map<String, Object> map) {
		return sqlSession.insert("erp.mStockInsert",map);
	}

	
	
	
	
	

	@Override
	public EmpBoard selectEmpStock(Map<String, Object> map) {
		return sqlSession.selectOne("erpBoard.selectEmpStock", map);
	}

	@Override
	public int empBoardDelete(int boardNo) {
		return sqlSession.delete("erpBoard.empBoardDelete", boardNo);
	}

	@Override
	public List<EmpBoardImage> selectBoardImage(int boardNo) {
		return sqlSession.selectList("erpBoard.selectOneBoardImage", boardNo);
	}

	@Override
	public int empBoardUpdate(EmpBoard empBoard) {
		return sqlSession.update("erpBoard.empBoardUpdate", empBoard);
	}

	@Override
	public int empBoardFileDelete(int boardNo) {
		return sqlSession.delete("erpBoard.empBoardFileDelete", boardNo);
	}

	@Override
	public int empBoardFileUpdate(EmpBoardImage updateImages) {
		return sqlSession.update("erpBoard.empBoardFileUpdate", updateImages);
	}

	
	
	
	
}
