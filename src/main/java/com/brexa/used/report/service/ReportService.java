package com.brexa.used.report.service;

import java.util.List;

import com.brexa.used.comm.SearchCondition;
import com.brexa.used.report.vo.ReportVO;

public interface ReportService {
	public int repoWrite(ReportVO rvo); // 신고 등록
	public List<ReportVO> repoList(SearchCondition sc); // 신고 목록 조회
	public int repoBan(ReportVO rvo); // 계정 상태 변경
	public int updateRcnt(String mno); // 신고 횟수
	public int repoMaxno(); // 신고 채번
	public int repoCnt(SearchCondition sc); //총 신고 횟수
	public int repoCount(String mno);
}
