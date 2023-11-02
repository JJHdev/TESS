package business.biz.evalu;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import oracle.net.aso.p;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import business.biz.comm.CommService;
import commf.dao.CommonDAOImpl;
import common.base.BaseService;
import common.util.CommUtils;
import common.util.paging.PaginatedArrayList;


/**
 * Program Name    : EvaluMgmtService
 * Description     : 관리/운영 개발사업관리 Service
 * Programmer Name : LCS
 * Creation Date   : 2014-09-29
 * Used Table(주요) :
 * 
 * @author LCS
 *
 */
@Service
@SuppressWarnings({"rawtypes", "unchecked"})
public class EvaluMgmtService extends BaseService {
    
    @Autowired
    private CommonDAOImpl dao;
    
    @Autowired
    private  EvaluCommService evaluCommService;
    
    @Autowired
    private EvaluFileService evaluFileService;
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // 조회
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    // 페이징을 위한 리스트 조회
    public PaginatedArrayList listEvaluMgmt(Map paramMap, int currPage, int pageSize) throws Exception {
        return dao.pageList("EvaluMgmt.listEvaluMgmt", paramMap, currPage, pageSize);
    }
    
    // 리스트 조회.
    public List listEvaluMgmt(Map paramMap) throws Exception {
        return dao.list("EvaluMgmt.listEvaluMgmt", paramMap);
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // 저장
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    
    /**
     * 저장처리
     * @param paramMap
     * @return
     * @throws Exception
     */
    public String saveEvaluMgmt(Map paramMap, List upfileInfoList) throws Exception {
        
        int    pCnt   = 0;
        String rtnMsg = "";
        String mode   = (String)paramMap.get("mode" );
        
        // 관광개발사업번호
        String evaluBusiNo = (String)paramMap.get("evaluBusiNo");
        
        //-----------
        // 삭제
        //-----------
        if(evaluCommService.MODE_DELT.equals(mode)){
            
            
        }
        //-----------
        // 등록/수정
        //-----------
        else {
            
            //-------------------------
            // Master 테이블(TB_Evalu_BUSI) 저장
            //-------------------------
            
            // 등록
            if(evaluCommService.MODE_REGI.equals(mode)){
                //지자체코드(REQ_CITYAUTH_CD) 항목을 설정해야 함.
                evaluBusiNo = regiEvaluMgmtMast(paramMap);
                if(!CommUtils.empty(evaluBusiNo)){
                    paramMap.put("evaluBusiNo", evaluBusiNo);
                    pCnt ++;
                }
            }
            // 수정
            else if(evaluCommService.MODE_UPDT.equals(mode)){
                // 수정 처리
                pCnt += updtEvaluMgmtMast(paramMap);
            } 
            
            //[CHECK ERROR] 관광개발사업번호가 비어 있거나 형식에 맞지 않으면 오류
            String chkBusiNoErrMsg = evaluCommService.checkValidEvaluNo(evaluBusiNo);
            if(!CommUtils.empty(chkBusiNoErrMsg)) 
                throw processException(chkBusiNoErrMsg);
            
            //-------------------------
            // 파일업로드 정보 초기 설정
            //-------------------------
            
            // 파일정보추가설정 : docuType, atthType, rootNo, regiId, updtId 등.
            evaluFileService.initMetaInfoUpfileList(paramMap, upfileInfoList);
            
            //--------------------------------
            // 파일 저장
            //--------------------------------
            
            // - 파일삭제 대상 문자열에 등록된 모든 파일을 삭재
            // - 화면에서 전달된 신규 파일 추가 처리.
            evaluFileService.fileManagement(paramMap, upfileInfoList);
            
        }   // end of 'else' - 등록/수정
        
        // 저장된 결과 count가 0이면 오류 처리.
        if(pCnt == 0) {
            // msg : 저장 처리된 내용이 없습니다.
            throw processException("exception.Evalu.dataNotProcData");
        }
        
        return rtnMsg;
    }
    
    /**
     * 해당 관광개발사업번호의 모든 data를 삭제한다.
     * @param paramMap
     * @return
     * @throws Exception
     */
    public int deltEvaluMgmtAll(Map paramMap) throws Exception {
        int pCnt = 0;    
        
        
        //[CHECK ERROR] 삭제 처리전 상태 검사.
        Map mastMap = viewEvaluMgmtMast(paramMap);
        String errMsg = evaluCommService.checkPreDelt(mastMap, paramMap);
        if(!CommUtils.empty(errMsg)) 
            throw processException(errMsg);
        
        //---------------------
        // 모든 첨부파일 삭제
        //---------------------
        // 관광개발사업 정보 전체를 삭제할 때 관련된 File 삭제.
        Map dfMap = new HashMap();
        dfMap.put("rootNo", paramMap.get("EvaluBusiNo"));
        pCnt += evaluFileService.deltAllFiles(dfMap);
        
        //---------------------
        // Master table (TB_Evalu_BUSI) 삭제
        //---------------------
        pCnt += deltEvaluMgmtMast(paramMap);
        
        return pCnt;
    }
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // TB_EVALU_BUSI     (관광사업정보) 관련
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    public Map viewEvaluMgmtMast(Map paramMap) throws Exception {
        return (Map)dao.view("EvaluMgmt.viewEvaluMgmtMast", paramMap);
    } 
    
    public String regiEvaluMgmtMast(Map paramMap) throws Exception {
        // 필요한 변환을 위해 map을 새로 생성.(변환된 내용이 적용되지 않게)
        Map nMap = new HashMap(paramMap);
        
        // setConvertMapData으로 변환작업을 수행
        return (String)dao.insert("EvaluMgmt.regiEvaluMgmtMast", evaluCommService.setConvertMapData(nMap));
    }
    
    public int updtEvaluMgmtMast(Map paramMap) throws Exception {
        // 필요한 변환을 위해 map을 새로 생성.(변환된 내용이 적용되지 않게)
        Map nMap = new HashMap(paramMap);
        // setConvertMapData으로 변환작업을 수행
        return dao.save("EvaluMgmt.updtEvaluMgmtMast", evaluCommService.setConvertMapData(nMap));
    }
    
    public int deltEvaluMgmtMast(Map paramMap) throws Exception {
        return dao.save("EvaluMgmt.deltEvaluMgmtMast", paramMap);
    }
    
    
//    listEvaluStgMgmt
    
    // 페이징을 위한 리스트 조회
    public PaginatedArrayList listEvaluStgMgmt(Map paramMap, int currPage, int pageSize) throws Exception {
        return dao.pageList("EvaluMgmt.listEvaluStgMgmt", paramMap, currPage, pageSize);
    }
    
    // 페이징을 위한 리스트 조회
    public List listEvaluItem(Map paramMap) throws Exception {
        return dao.list("EvaluMgmt.getBusiEvaluItem", paramMap);
    }
    
    // 페이징을 위한 리스트 조회
    public PaginatedArrayList listEvaluCommit(Map paramMap, int currPage, int pageSize) throws Exception {
        return dao.pageList("EvaluMgmt.listEvaluCommit", paramMap, currPage, pageSize);
    }
    
    //평가계획 등록
    public void saveEvaluStgMgmt(Map paramMap) throws Exception {
    	
    	String mode = (String)paramMap.get("mode");
    	String regiEvaluCommId = (String)paramMap.get("regiEvaluCommId");
    	
    	String arrEvaluCommId[] = regiEvaluCommId.split(",");
    	
    	int cnt =0;
    	
    	if(mode.equals(evaluCommService.MODE_REGI)){
    		dao.insert("EvaluMgmt.regiEvaluStgMgmt", paramMap);
    	}
    	else if(mode.equals(evaluCommService.MODE_UPDT)){
    		
    		
    		try {
        		cnt += dao.delete("EvaluMgmt.deltEvaluCommitMgmt", paramMap);
        		cnt += dao.delete("EvaluMgmt.deltEvaluIndicatMgmt", paramMap);
			} catch (Exception e) {
                // msg : 이미 입력된 평가정보가 있습니다.
                throw processException("exception.Evalu.alreadyInptData");
			}
    		
    		if(cnt>0){
    			dao.update("EvaluMgmt.updtEvaluStgMgmt", paramMap);
    		}else{
                // msg : 저장 처리된 내용이 없습니다.
                throw processException("exception.Evalu.dataNotProcData");
    		}
    	}
    	else if(mode.equals(evaluCommService.MODE_DELT)){
    		
    	}
    	
    	for (int i = 0; i < arrEvaluCommId.length; i++) {
    		String evauId = arrEvaluCommId[i];
    		paramMap.put("evaluCommId", evauId);
    		dao.insert("EvaluMgmt.regiEvaluCommitMgmt", paramMap);
		}
    	
    	String [] arrEvaluItem = ((String)paramMap.get("paramEvaluItem")).split(",");
    	
    	for (int i = 0; i < arrEvaluItem.length; i++) {
    		paramMap.put("evaluIndicatCd", arrEvaluItem[i]);
    		dao.insert("EvaluMgmt.regiEvaluIndicatMgmt", paramMap);
		}
    	
    }
    
    // 페이징을 위한 리스트 조회
    public PaginatedArrayList listEvaluBudtMgmt(Map paramMap, int currPage, int pageSize) throws Exception {
        return dao.pageList("EvaluMgmt.listEvaluBudtMgmt", paramMap, currPage, pageSize);
    }
    
    public Map viewAllEvaluInfo(Map paramMap) throws Exception {
    	
    	Map rtnMap = new HashMap();
    	
    	Map stgMap = viewEvaluStgMgmt(paramMap);
    	
    	//평가결과 입력
    	int fndCnt =   Integer.parseInt( String.valueOf(stgMap.get("fndCnt")) );;
    	
    	System.out.println("CommUtils.empty(fndCnt) " + fndCnt);
    
    	//정상
//    	if(fndCnt == 0){		//DB입력을 위해 임시 주석처리 if~else구문
    		
    		paramMap.put("evaluStage", stgMap.get("evaluStage"));
        	
        	List indiList;	
        	List commList;
        	
        	indiList = dao.list("EvaluMgmt.viewEvaluIndiMgmt", paramMap);
        	
        	String arrIndi = "";
        	
        	for (int i = 0; i < indiList.size(); i++) {
        		Map map = (Map)indiList.get(i);
        		String strIndi = (String)map.get("evaluIndicatCd");
        		
        		arrIndi = ( arrIndi.equals("") ) ? strIndi : arrIndi + "," + strIndi;
    		}
        	
        	commList = dao.list("EvaluMgmt.viewEvaluCommMgmt", paramMap);
        	
        	rtnMap.put("stgMap", stgMap);
        	rtnMap.put("indiList", indiList);
        	rtnMap.put("arrIndi", arrIndi);
        	rtnMap.put("commList", commList);
//    	}
    	//비정상
//    	else{
//            // msg : 저장 처리된 내용이 없습니다.
//            throw processException("exception.tode.viewNotSrchData");
//    	}
    	
    	
    	return rtnMap;
    } 
    
    public Map viewEvaluStgMgmt(Map paramMap) throws Exception {
    	return (Map)dao.view("EvaluMgmt.viewEvaluStgMgmt", paramMap);
    }
    
    public Map viewEvaluBudtMgmt(Map paramMap) throws Exception {
    	return (Map) dao.view("EvaluMgmt.viewEvaluBudtMgmt", paramMap);
    } 
    
    public List viewEvaluBudtMgmt2(Map paramMap) throws Exception {
    	return dao.list("EvaluMgmt.viewEvaluBudtMgmt2", paramMap);
    } 
    
    //중앙투자심사 등록 - 첨부파일 입력
    public void regiEvaluCentMgmt410(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluCentMgmt410", paramMap);
    }
    //중앙투자심사 등록 - 판정 의견 결과 입력
    public void regiEvaluCentMgmt310(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluCentMgmt310", paramMap);
    }

    //중앙투자심사 등록 - 종합의견2(사업추진의 필요성 및 당위성에 관한 의견) 입력
    public void regiEvaluCentMgmt210(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluCentMgmt210", paramMap);
    }
    
    //중앙투자심사 등록 - 종합의견2(개선 의견) 입력
    public void regiEvaluCentMgmt220(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluCentMgmt220", paramMap);
    }
    
    //중앙투자심사 등록 - 종합의견2(권고(자문) 사항) 입력
    public void regiEvaluCentMgmt230(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluCentMgmt230", paramMap);
    }

    //중앙투자심사 등록 - 판정의견 결과 입력
    public void regiEvaluCentMgmt110(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluCentMgmt110", paramMap);
    }
    
    //집행평가 등록 - 판정의견 입력
    public void regiEvaluProgMgmt310(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluProgMgmt310", paramMap);
    }
    
    //집행평가 등록 - 권고(자문)사항 입력
    public void regiEvaluProgMgmt220(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluProgMgmt220", paramMap);
    }
    
    //집행평가 등록 - 개선의견 입력
    public void regiEvaluProgMgmt210(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluProgMgmt210", paramMap);
    }
    
    //집행평가 등록 - 검토의견서 입력
    public void regiEvaluProgMgmt110(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluProgMgmt110", paramMap);
    }

    //사전평가 등록 - 검토의견서 입력
    public void regiEvaluPrevMgmt110(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt110", paramMap);
    }

    //사전평가 등록 - PV510
    public void regiEvaluPrevMgmt510(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt510", paramMap);
    }
    
    //사전평가 등록 - PV520
    public void regiEvaluPrevMgmt520(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt520", paramMap);
    }
    
    //사전평가 등록 - PV530
    public void regiEvaluPrevMgmt530(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt530", paramMap);
    }
    
    //사전평가 등록 - PV610
    public void regiEvaluPrevMgmt610(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt610", paramMap);
    }
    
    //사전평가 등록 - PV620
    public void regiEvaluPrevMgmt620(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt620", paramMap);
    }
    
    //사전평가 등록 - PV630
    public void regiEvaluPrevMgmt630(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt630", paramMap);
    }
    
    //사전평가 등록 - PV640
    public void regiEvaluPrevMgmt640(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt640", paramMap);
    }
    
    //사전평가 등록 - PV650
    public void regiEvaluPrevMgmt650(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt650", paramMap);
    }
    
    //사전평가 등록 - PV660
    public void regiEvaluPrevMgmt660(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt660", paramMap);
    }
    
    //사전평가 등록 - PV710
    public void regiEvaluPrevMgmt710(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt710", paramMap);
    }
    
    //사전평가 등록 - PV720
    public void regiEvaluPrevMgmt720(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt720", paramMap);
    }
    
    //사전평가 등록 - PV730
    public void regiEvaluPrevMgmt730(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt730", paramMap);
    }

    //사전평가 진단평가표 - PV211
    public void regiEvaluPrevMgmt211(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt211", paramMap);
    }
    
    //사전평가 진단평가표 - PV212
    public void regiEvaluPrevMgmt212(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt212", paramMap);
    }
    
    //사전평가 진단평가표 - PV213
    public void regiEvaluPrevMgmt213(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt213", paramMap);
    }
    
    //사전평가 진단평가표 - PV221
    public void regiEvaluPrevMgmt221(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt221", paramMap);
    }
    
    //사전평가 진단평가표 - PV222
    public void regiEvaluPrevMgmt222(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt222", paramMap);
    }
    
    //사전평가 진단평가표 - PV223
    public void regiEvaluPrevMgmt223(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt223", paramMap);
    }
    
    //사전평가 진단평가표 - PV311
    public void regiEvaluPrevMgmt311(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt311", paramMap);
    }
    
    //사전평가 진단평가표 - PV312
    public void regiEvaluPrevMgmt312(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt312", paramMap);
    }
    
    //사전평가 진단평가표 - PV321
    public void regiEvaluPrevMgmt321(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt321", paramMap);
    }
    
    //사전평가 진단평가표 - PV322
    public void regiEvaluPrevMgmt322(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt322", paramMap);
    }
    
    //사전평가 진단평가표 - PV331
    public void regiEvaluPrevMgmt331(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt331", paramMap);
    }
    
    //사전평가 진단평가표 - PV332
    public void regiEvaluPrevMgmt332(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt332", paramMap);
    }
    
    //사전평가 진단평가표 - PV341
    public void regiEvaluPrevMgmt341(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt341", paramMap);
    }
    
    //사전평가 진단평가표 - PV342
    public void regiEvaluPrevMgmt342(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt342", paramMap);
    }
    
    //사전평가 진단평가표 - PV411
    public void regiEvaluPrevMgmt411(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt411", paramMap);
    }
    
    //사전평가 진단평가표 - PV412
    public void regiEvaluPrevMgmt412(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt412", paramMap);
    }
    
    //사전평가 진단평가표 - PV413
    public void regiEvaluPrevMgmt413(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt413", paramMap);
    }
    
    //사전평가 진단평가표 - PV421
    public void regiEvaluPrevMgmt421(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt421", paramMap);
    }
    
    //사전평가 진단평가표 - PV422
    public void regiEvaluPrevMgmt422(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt422", paramMap);
    }
    
    //사전평가 진단평가표 - PV423
    public void regiEvaluPrevMgmt423(Map paramMap) throws Exception {
    	dao.update("EvaluMgmt.regiEvaluPrevMgmt423", paramMap);
    }
    
    
    
    //평가계획 등록
    public void saveEvaluBudtMgmt(Map paramMap) throws Exception {
    	
    	String mode = (String)paramMap.get("mode");
    	int cnt =0;
    	String evaluFndSeq;
    	
    	//컬럼항목
    	String[] arrEvaluInptCulm = ((String)paramMap.get("evaluInptCulm")).split(",");
    	Map vbMap = new HashMap();
    	
    	vbMap.put("evaluBusiNo", paramMap.get("evaluBusiNo"));
    	vbMap.put("evaluStage", paramMap.get("evaluStage"));
    	vbMap.put("evaluId", paramMap.get("evaluId"));
    	vbMap.put("curtEvaluCode", paramMap.get("curtEvaluCode"));
    	vbMap.put("nextEvaluCode", paramMap.get("nextEvaluCode"));
    	vbMap.put("evaluProcStep", paramMap.get("evaluProcStep"));
    	
		for (int i = 0; i < arrEvaluInptCulm.length; i++) {
			
			//EVALU_INDICAT_CD
			String evaluCode = arrEvaluInptCulm[i];
			
			if(mode.equals(evaluCommService.MODE_REGI)){
				String evaluProcStep = (String)paramMap.get("evaluProcStep");
				
				String evaluStage = (String)paramMap.get("evaluStage");
				
				if(evaluStage.equals("EVALU_DPTH")){
					vbMap.put("evaluInputCd", evaluCode);
				}else{
					if(evaluProcStep.equals("AS10") || evaluProcStep.equals("AS20")){
						vbMap.put("evaluInputCd", evaluCode);
					}else if(evaluProcStep.equals("AS30")){
						vbMap.put("curtEvaluCode", evaluCode);
					}
				}
			}

			//EVALU_FND_VALUE
			String evaluFndVal = (String)paramMap.get(evaluCode);
			vbMap.put("evaluFndVal", evaluFndVal);
			
			//EVALU_FND_VALUE
			String evaluEtcVal = (String)paramMap.get("txt"+evaluCode);
			vbMap.put("evaluEtcVal", evaluEtcVal);	
			
			//EVALU_Etc_Seq
			String evaluEtcSeq = (String)paramMap.get("seq"+evaluCode);
			vbMap.put("evaluEtcSeq", evaluEtcSeq);	
			if(CommUtils.empty(evaluEtcSeq)){
				vbMap.put("evaluEtcSeq", 1);
				paramMap.put("evaluEtcSeq", evaluEtcSeq);
			}
			
	        //-----------
	        // 삭제
	        //-----------
			 if(mode.equals(evaluCommService.MODE_DELT)){
		    		
		    }
	        //-----------
	        // 등록/수정
	        //-----------
			 else{
			    	if(mode.equals(evaluCommService.MODE_REGI)){
			    		
			    		evaluFndSeq = (String)dao.insert("EvaluMgmt.regiEvaluBudtMgmt", vbMap);
			    		if(!CommUtils.empty(evaluFndSeq)){
			    			cnt++;
			    			evaluFndSeq = null;
			    		}
			    	}
			    	else if(mode.equals(evaluCommService.MODE_UPDT)){
			    		
			        	//수정할 seq값
			        	String[] arrevaluFndSeq = ((String)paramMap.get("evaluFndSeq")).split(",");
			        	vbMap.put("evaluFndSeq", arrevaluFndSeq[i]);
			    		
			    		cnt += dao.update("EvaluMgmt.updtEvaluBudtMgmt", vbMap);	
			    	}
			 }
		}
		
		if(!paramMap.get("evaluProcStep").equals("AS90")){
			//현재 단계 저장
			dao.update("EvaluMgmt.updtEvaluProcStep", vbMap);
		}
		
        // 저장된 결과 count가 0이면 오류 처리.
        if(cnt == 0) {
            // msg : 저장 처리된 내용이 없습니다.
            throw processException("exception.Evalu.dataNotProcData");
        }
		
    }
    
    public List listEvaluFnd(Map paramMap) throws Exception {
    	
    	List list = dao.list("EvaluMgmt.viewEvaluFnd", paramMap);
    	
    	
    	String mode = (String)	paramMap.get("mode");
    	
    	if(mode.equals("updt")){
    	
	    	if(list.isEmpty()){
	    		
	        	List inptList = (List)paramMap.get("evaluInptItem");
	        	
	        	String evaluInptCulm = null;
	        	Map tempMap;
	        	
	        	for (int i = 0; i < inptList.size(); i++) {
	        		tempMap = (Map)inptList.get(i);
	        		evaluInptCulm = (String)tempMap.get("code");
	        		
	        		String evaluDetailCode = (String)paramMap.get("evaluDetailCode");
	        		
	        		if(CommUtils.empty(evaluDetailCode)){
	        			paramMap.put("curtEvaluCode", evaluInptCulm);
	        		}else{
		        		paramMap.put("curtEvaluCode", paramMap.get("evaluDetailCode"));
		        		paramMap.put("evaluInputCd", evaluInptCulm);
	        		}
	        		
	        		paramMap.put("evaluEtcSeq", 1);
	        		dao.insert("EvaluMgmt.regiEvaluBudtMgmt", paramMap);
	    		}
	        	
	        	return listEvaluFnd(paramMap);
	    	}
    	}
    	
    	return list;
    }     
    
    public int getEvaluEtcSeq(Map paramMap) throws Exception {
    	
    	int etcSeq = 1;
    	
    	String strEtcSeq = (String)dao.view("EvaluMgmt.getEvaluEtcSeq", paramMap);
    	
    	if(CommUtils.empty(strEtcSeq)){
    		
    		List inptList = (List)paramMap.get("evaluInptItem");
    		
        	String evaluInptCulm = null;
        	Map tempMap;
        	
        	for (int i = 0; i < inptList.size(); i++) {
        		tempMap = (Map)inptList.get(i);
        		evaluInptCulm = (String)tempMap.get("code");
        		
        		String evaluDetailCode = (String)paramMap.get("evaluDetailCode");
        		
        		if(CommUtils.empty(evaluDetailCode)){
        			paramMap.put("curtEvaluCode", evaluInptCulm);
        		}else{
	        		paramMap.put("curtEvaluCode", paramMap.get("evaluDetailCode"));
	        		paramMap.put("evaluInputCd", evaluInptCulm);
        		}
    		
        		dao.insert("EvaluMgmt.regiEvaluBudtMgmt", paramMap);
        	}
        	
    	}else {
    		etcSeq = Integer.parseInt(strEtcSeq);
    	}
    	
    	return etcSeq;
    }   
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // 파일 관련
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    /**
     * 첨부파일 리스트 조회 (docuType별로 조회)
     * @param paramMap
     * @return
     * @throws Exception
     */
    public List listEvaluFile(Map paramMap) throws Exception {
        List<Map> list = evaluFileService.listEvaluFile(paramMap);
        
        return list;
    }
    
    /**
     * 파일 정보 조회.
     * @param paramMap
     * @return
     * @throws Exception
     */
    public Map viewEvaluFile(Map paramMap) throws Exception {
        return evaluFileService.viewEvaluFile(paramMap);
    }
    
    public void updtEvaluFinalAppr(Map paramMap) throws Exception {
    	
    	int cnt = 0;
    	
    	cnt += dao.update("EvaluMgmt.updtEvaluFinalAppr", paramMap);
    	
    	//승인 완료단계로 변경
    	paramMap.put("evaluProcStep", "AS90");
    	
    	cnt += dao.update("EvaluMgmt.updtEvaluProcStep", paramMap);
    	
        // 저장된 결과 count가 0이면 오류 처리.
        if(cnt == 0) {
            // msg : 저장 처리된 내용이 없습니다.
            throw processException("exception.Evalu.dataNotProcData");
        }
    	
    }
    
    
    
    //++++++++++++++++++++++++++++++++++++++++++++++
    // 기타
    //++++++++++++++++++++++++++++++++++++++++++++++
    
    //viewEvaluMgmtDefaultCityauthNm : cityauthCd를 통해 지자체 지역 코드에대한 한글 명 조회
    public Map viewEvaluMgmtDefaultCityauthNm(Map paramMap) throws Exception {
        return (Map)dao.view("EvaluMgmt.viewEvaluMgmtDefaultCityauthNm", paramMap);
    }
}
