package com.kh.mate.cs.model.service;

import java.util.List;
import java.util.Map;

import com.kh.mate.cs.model.vo.Cs;

public interface CsService {

	int insertCs(Cs cs);

	List<Cs> selectCsList();

	int deleteCs(int csNo);

}
