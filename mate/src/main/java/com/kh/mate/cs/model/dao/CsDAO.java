package com.kh.mate.cs.model.dao;

import java.util.List;

import com.kh.mate.cs.model.vo.Cs;

public interface CsDAO {

	int insertCs(Cs cs);

	List<Cs> selectCsList();

}
