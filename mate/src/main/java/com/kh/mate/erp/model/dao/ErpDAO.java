package com.kh.mate.erp.model.dao;

import java.util.List;

import com.kh.mate.erp.model.vo.EMP;

public interface ErpDAO {

	int insertEmp(EMP emp);

	EMP selectOneEmp(String empId);

	List<EMP> empList();

}
