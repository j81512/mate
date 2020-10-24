package com.kh.mate.erp.model.service;

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

public interface ErpService {

	int insertEmp(EMP emp);

	EMP selectOneEmp(String empId);

	List<Product> searchInfo(Map<String, Object> map);

	List<EMP> empList();

	Product orderProduct(Map<String, Object> map);

	int productEnroll(Product product);

	Product selectProductOne(String productNo);

	List<ProductMainImages> selectProductMainImages(String productNo);

	int productUpdate(Product product);

	int productDelete(String productNo);

	List<ProductImages> selectProductImages(String productNo);

	int productOrder(Product product);

	EmpBoard selectOneEmpBoard(int no, boolean hasRead);

	List<EmpBoardReply> replyList(int boardNo);

	int boardReply(EmpBoardReply boardReply);

	int deleteReply(int boardReplyNo);

	int infoUpdate(EMP emp);

	int infoDelete(Map<String, Object> map);

	int updateReply(Map<String, Object> map);

	int insertEmpBoard(EmpBoard empBoard);

	EmpBoardImage empBoardFileDownload(int boardImageNo);

	List<Product> erpProductList();

	List<EmpBoard> searchBoard(String searchType, String searchKeyword, int cPage, int numPerPage);

	int getSearchContents(Map<String, String> map);

	List<IoLog> ioLogList();

	List<Product> productList();

	List<Receive> receiveList();

	List<RequestLog> requestList();

	EmpBoard selectEmpStock(Map<String, Object> map);


}
