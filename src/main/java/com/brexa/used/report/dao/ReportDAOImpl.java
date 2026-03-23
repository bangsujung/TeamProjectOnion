package com.brexa.used.report.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.brexa.used.comm.SearchCondition;
import com.brexa.used.report.vo.ReportVO;

@Repository // 데이터베이스에 접근하는 파일
public class ReportDAOImpl implements ReportDAO{
	@Autowired
	private SqlSession session;
	private String namespace = "com.brexa.used.mapper.ReportMapper.";
	private String mnamespace = "com.brexa.used.mapper.MemberMapper.";
	
	@Override
	public int repoWrite(ReportVO rvo) {
		// TODO Auto-generated method stub
		System.out.println("ReportDAO repoWrite 함수 진입 >>>>");
		System.out.println("rvo >> " + rvo);
		int res = session.insert(namespace+"repoWrite",rvo);
		System.out.println("res >> " + res);
		return res;
	}
	
	@Override
	public List<ReportVO> repoList(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("ReportDAO repoList 함수 진입 >>>>");
		System.out.println("sc >> " + sc);
		List<ReportVO> rList = session.selectList(namespace+"repoList", sc);
	    System.out.println("rList >> "+rList);
	    return rList;
	}
	
	@Override
	public int repoBan(ReportVO rvo) {
		// TODO Auto-generated method stub
		System.out.println("ReportDAO repoBan 함수 진입 >>>>");
		System.out.println("rvo >> " + rvo);
		int res = session.update(mnamespace + "repoBan", rvo);
        System.out.println("res >> " + res);
        return res;
	}

	@Override
	public int updateRcnt(String mno) {
		// TODO Auto-generated method stub
		System.out.println("ReportDAO updateRcnt 함수 진입 >>>>");
		System.out.println("mno >> " + mno);
		int res = session.update(namespace+"updateRcnt",mno);
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int repoMaxno() {
		// TODO Auto-generated method stub
		System.out.println("ReportDAO repoMaxno 함수 진입 >>>>");
		int maxno = session.selectOne(namespace+"repoMaxno");
		System.out.println("maxno >> " + maxno);
		return maxno;
	}

	@Override
	public int repoCnt(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("ReportDAO repoCnt 함수 진입 >>>>");
		System.out.println("sc >> " + sc);
		int repoCnt = session.selectOne(namespace + "repoCnt", sc);
		System.out.println("repoCnt >> " + repoCnt);
	    return repoCnt;
	}

	@Override
	public int repoCount(String mno) {
		// TODO Auto-generated method stub
		System.out.println("ReportDAO repoCount() 함수 진입 =======");
	    System.out.println("mno >> " + mno);
	    int cnt = session.selectOne(namespace + "repoCount", mno);
	    System.out.println("cnt >> " + cnt);
	    return cnt;
	}
}
