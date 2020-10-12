package com.kh.mate.erp.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.erp.model.dao.ErpDAO;
import com.kh.mate.erp.model.vo.EMP;

@Service
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
	
	
}
