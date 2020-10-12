package com.kh.mate.cs.model.service;

import java.util.List;
import java.util.Map;

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

	@Override
	public List<Cs> selectCsList() {
		
		return csDAO.selectCsList();
	}
	@Override
	public int deleteCs(Map<String, String> param) {
		
		return csDAO.deleteCs(param);
	}
}
