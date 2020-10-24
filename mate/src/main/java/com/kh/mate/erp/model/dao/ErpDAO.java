package com.kh.mate.erp.model.dao;

import java.util.List;
import java.util.Map;

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

public interface ErpDAO {

	int insertEmp(EMP emp);

	EMP selectOneEmp(String empId);

	List<Product> searchInfo(Map<String, Object> map);

	List<EMP> empList();

	Product orderProduct(Map<String, Object> map);

	int productEnroll(Product product);

	int productImageEnroll(ProductImages pigs);

	Product selectProductOne(String productNo);

	List<ProductMainImages> selectProductMainImages(String productNo);


	int productMainImagesEnroll(ProductMainImages mainImg);

	int productUpdate(Product product);

	int productMainImagesDelete(String productNo);

	int productDelete(String productNo);

	List<ProductImages> selectProductImages(String productNo);

	int productImagesDelete(String productNo);

	String findEmpid(int productNo);

	int productOrder(Product product);
	
	
	EmpBoard selectOneEmpBoard(int no);


	List<EmpBoardReply> replyList(int boardNo);

	int boardReply(EmpBoardReply boardReply);

	int deleteReply(int boardReplyNo);

	int infoUpdate(EMP emp);

	int infoDelete(Map<String, Object> map);

	int updateReply(Map<String, Object> map);


	int inserEmpBoard(EmpBoard empBoard);

	int inserEmpBoardImage(EmpBoardImage empBoardImage);

	EmpBoardImage empBoardFileDownload(int boardImageNo);

	List<Product> erpProductList();

	int insertRequestStock(EmpBoard empBoard);

	int increaseReadCount(int no);

	List<EmpBoard> searchBoard(String searchType, String searchKeyword, int cPage, int numPerPage);

	int getSearchContents(Map<String, String> map);


	List<IoLog> ioLogList();

	List<Product> productList();

	List<Receive> receiveList();

	List<RequestLog> requestList();

	List<RequestLog> selectRequsestList(String empId);

	int updateRequestToApp(int requestNo);

	int updateRequestToRef(int requestNo);

	List<Receive> selectReceiveList(String empId);

	int updateReceiveToApp(int receiveNo);

	int updateReceiveToRef(int receiveNo);


}
