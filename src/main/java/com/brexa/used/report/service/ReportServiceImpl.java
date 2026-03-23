package com.brexa.used.report.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.brexa.used.comm.Chaebun;
import com.brexa.used.comm.SearchCondition;
import com.brexa.used.item.dao.ItemDAO;
import com.brexa.used.report.dao.ReportDAO;
import com.brexa.used.report.vo.ReportVO;

@Service
public class ReportServiceImpl implements ReportService{
	@Autowired
	private ReportDAO rdao;

	@Transactional //여러 개의 DB 작업을 하나로 묶어서, 중간에 하나라도 실패하면 앞서 성공한 것들까지 전부 취소(Rollback)
    @Override
    public int repoWrite(ReportVO rvo) {
       // TODO Auto-generated method stub
       System.out.println("ReportService repoWrite 함수 진입 >>>>");
       System.out.println("rvo >> " + rvo);
       
        int nextNo = rdao.repoMaxno();
        
        String rno = Chaebun.getReport(nextNo); 
        rvo.setRno(rno); 
        
        System.out.println("생성된 신고번호(RNO) >> " + rno);
       
       // 신고 내역 DB에 저장 (REPORT 테이블)
       int res = rdao.repoWrite(rvo);
       
       if (res > 0) {
          // 해당 유저의 RCNT를 1 증가 (MEMBER 테이블)
             rdao.updateRcnt(rvo.getMno()); 
             System.out.println(rvo.getMno() + "번 유저 신고 횟수 업데이트 완료");
             
           //총 신고 횟수 확인 후 5회 이상이면 자동 정지
           int cnt = rdao.repoCount(rvo.getMno());
           System.out.println("★ [검증] 현재 " + rvo.getMno() + " 유저의 DB 신고 데이터 개수: " + cnt);
           
           if(cnt >= 5) {
              rdao.repoBan(rvo);
              System.out.println(rvo.getMno() + " >> 신고 누적 5회 달성. 계정 영구 정지");
           }
         }
       System.out.println("최종 결과 res >> " + res);
       return res;
    }


	@Override
	public List<ReportVO> repoList(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("ReportService repoList 함수 진입 >>>>");
		System.out.println("sc >> " + sc);
		List<ReportVO> rList = rdao.repoList(sc);
		System.out.println("rList >> " + rList);
	    return rList;
	}

	@Override
	public int repoBan(ReportVO rvo) {
		// TODO Auto-generated method stub
		System.out.println("ReportService repoBan() 함수 진입 ========");
	    System.out.println("rvo >> " + rvo);
	    int res = rdao.repoBan(rvo);
	    System.out.println("res >> " + res);
	    return res;
	}

	@Override
	public int updateRcnt(String mno) {
		// TODO Auto-generated method stub
		System.out.println("ReportService updateRcnt 함수 진입 >>>>");
		System.out.println("mno >> " + mno);
		int res = rdao.updateRcnt(mno);
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int repoMaxno() {
		// TODO Auto-generated method stub
		System.out.println("ReportService repoMaxno 함수 진입 >>>>");
		int res = rdao.repoMaxno();
		System.out.println("res >> " + res);
		return res;
	}

	@Override
	public int repoCnt(SearchCondition sc) {
		// TODO Auto-generated method stub
		System.out.println("ReportService repoCnt 함수 진입 >>>>");
		System.out.println("sc >> " + sc);
		int repoCnt = rdao.repoCnt(sc);
		System.out.println("repoCnt >> " + repoCnt);
	    return repoCnt;
	}

	@Override
	public int repoCount(String mno) {
		// TODO Auto-generated method stub
		System.out.println("ReportService repoCount() 함수 진입 =======");
	    System.out.println("mno >> " + mno);
	    int cnt = rdao.repoCount(mno);
	    System.out.println("cnt >> " + cnt);
	    return cnt;
	}
}
