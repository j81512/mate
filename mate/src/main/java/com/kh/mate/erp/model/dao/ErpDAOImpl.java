package com.kh.mate.erp.model.dao;

import java.util.List;

import java.util.Map;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.mate.erp.model.vo.EMP;
import com.kh.mate.erp.model.vo.EmpBoard;
import com.kh.mate.erp.model.vo.EmpBoardReply;
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
	public List<Product> searchInfo(Map<String, Object> map) {
		return sqlSession.selectList("erp.searchInfo",map);
	}
	
	
  @Override
	public List<EMP> empList() {
		return sqlSession.selectList("emp.empList");
	}

	@Override
	public Product orderProduct(Map<String, Object> map) {
		return sqlSession.selectOne("erp.orderProduct",map);
	}
	
	@Override
	public String findEmpid(int productNo) {
		return sqlSession.selectOne("erp.findEmpid",productNo);
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

	//호근 추가
	@Override
	public List<Map<String, Object>> empBoardList() {
		return sqlSession.selectList("erpBoard.empBoard");
	}

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
	
	
	
	
	
  

	
}
