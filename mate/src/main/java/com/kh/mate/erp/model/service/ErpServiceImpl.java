package com.kh.mate.erp.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.erp.model.dao.ErpDAO;

@Service
public class ErpServiceImpl implements ErpService {

	@Autowired
	private ErpDAO erpDAO;
	
	
}
