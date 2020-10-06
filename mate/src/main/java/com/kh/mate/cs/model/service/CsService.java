package com.kh.mate.cs.model.service;

import java.util.List;

import com.kh.mate.cs.model.vo.Cs;

public interface CsService {

	int insertCs(Cs cs);

	List<Cs> selectCsList();

}
