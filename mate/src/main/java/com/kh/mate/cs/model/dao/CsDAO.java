package com.kh.mate.cs.model.dao;

import java.util.List;

import com.kh.mate.cs.model.vo.CsImages;
import com.kh.mate.cs.model.vo.Cs;


public interface CsDAO {

	int insertCs(Cs cs);

	List<Cs> selectCsList();

	int deleteCs(int csNo);

	CsImages selectOneAttachment(int csNo);
	
	Cs selectOneCsCollection(int csNo);

	Cs selectOneCs(int csNo);

	int insertCsImage(CsImages csImage);

	CsImages selectCsImage(int csNo);
}
