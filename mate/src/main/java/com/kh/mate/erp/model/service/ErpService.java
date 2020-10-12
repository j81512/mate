package com.kh.mate.erp.model.service;

import java.util.List;

import com.kh.mate.erp.model.vo.EMP;

public interface ErpService {

	int insertEmp(EMP emp);

	EMP selectOneEmp(String empId);

	List<EMP> empList();


}
