package com.kh.mate.cs.model.service;

import java.util.List;

import com.kh.mate.cs.model.vo.Cs;
import com.kh.mate.cs.model.vo.CsImages;

public interface CsService {

	List<Cs> selectCsList();

	int insertCs(Cs cs);

	int deleteCs(int csNo);
	
	Cs selectOneCs(int csNo);

	Cs selectOneCsCollection(int csNo);

	CsImages selectOneAttachment(int csNo);

	

}
