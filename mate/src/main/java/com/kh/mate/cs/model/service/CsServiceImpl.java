package com.kh.mate.cs.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.mate.cs.model.dao.CsDAO;
import com.kh.mate.cs.model.vo.Cs;

@Service
public class CsServiceImpl implements CsService {

	@Autowired
	private CsDAO csDAO;

	@Override
	public int insertCs(Cs cs) {
		
		return csDAO.insertCs(cs);
	}
}
