-- 2023.11.17 LHB 평가지표 관련
CREATE TABLE TB_EVL_IX
(
	-- 평가지표 일련번호
	EVL_IX_SN number NOT NULL,
	-- 평가지표 연도
	EVL_IX_YR varchar2(4 char),
	-- 평가지표 평가단계
	EVL_IX_STEP varchar2(20 char),
	-- 등록자
	REGI_ID varchar2(20 char),
	-- 등록일자
	REGI_DATE timestamp,
	-- 수정자
	UPDT_ID varchar2(20 char),
	-- 수정일자
	UPDT_DATE timestamp,
	PRIMARY KEY (EVL_IX_SN)
);


-- 평가 지표 항목
CREATE TABLE TB_EVL_IX_ARTCL
(
	-- 평가지표항목 일련번호
	EVL_IX_ARTCL_SN number NOT NULL,
	-- 평가지표 일련번호
	EVL_IX_SN number NOT NULL,
	-- 상위 평가지표항목 일련번호
	UP_EVL_IX_ARTCL_SN number,
	-- 항목명
	ARTCL_NM varchar2(500 char),
	-- 추가컬럼1
	ADD_COL1 varchar2(500 char),
	-- 추가컬럼2
	ADD_COL2 varchar2(500 char),
	-- 추가컬럼3
	ADD_COL3 varchar2(500 char),
	-- 추가컬럼4
	ADD_COL4 varchar2(500 char),
	-- 추가컬럼5
	ADD_COL5 varchar2(500 char),
	-- 사용여부
	USE_YN varchar2(1 char),
	-- 합산여부
	ADUP_YN varchar2(1 char),
	-- 등록자
	REGI_ID varchar2(20 char),
	-- 등록일자
	REGI_DATE timestamp,
	-- 수정자
	UPDT_ID varchar2(20 char),
	-- 수정일자
	UPDT_DATE timestamp,
	PRIMARY KEY (EVL_IX_ARTCL_SN)
);


-- 평가 지표 항목 배점
CREATE TABLE TB_EVL_IX_ARTCL_ALLOT
(
	-- 평가지표항목배점 일련번호
	EVL_IX_ARTCL_ALLOT_SN number NOT NULL,
	-- 평가지표항목 일련번호
	EVL_IX_ARTCL_SN number NOT NULL,
	-- 순서
	ORDR number,
	-- 배점명
	ALLOT_NM varchar2(20 char),
	-- 배점값
	ALLOT_VL number,
	-- 등록자
	REGI_ID varchar2(20 char),
	-- 등록일자
	REGI_DATE timestamp,
	-- 수정자
	UPDT_ID varchar2(20 char),
	-- 수정일자
	UPDT_DATE timestamp,
	PRIMARY KEY (EVL_IX_ARTCL_ALLOT_SN)
);


-- 평가위원 데이터
CREATE TABLE TB_EVL_MFCMM_DATA
(
	-- 평가위원 데이터 일련번호
	EVL_MFCMM_DATA_SN number NOT NULL,
	-- 평가대상사업 이력 일련번호
	EVALU_HIST_SN number NOT NULL,
	-- 평가지표항목 일련번호
	EVL_IX_ARTCL_SN number NOT NULL,
	-- 평가지표항목배점 일련번호
	EVL_IX_ARTCL_ALLOT_SN number UNIQUE,
	-- 판단의견
	DCS_OPNN varchar2(4000 char),
	-- 개선사항
	IPM_NOTE varchar2(4000 char),
	-- 등록자
	REGI_ID varchar2(20 char),
	-- 등록일자
	REGI_DATE timestamp,
	-- 수정자
	UPDT_ID varchar2(20 char),
	-- 수정일자
	UPDT_DATE timestamp,
	PRIMARY KEY (EVL_MFCMM_DATA_SN)
);



/* Create Foreign Keys */

ALTER TABLE TB_EVL_IX_ARTCL
	ADD FOREIGN KEY (EVL_IX_SN)
	REFERENCES TB_EVL_IX (EVL_IX_SN)
;


ALTER TABLE TB_EVL_IX_ARTCL_ALLOT
	ADD FOREIGN KEY (EVL_IX_ARTCL_SN)
	REFERENCES TB_EVL_IX_ARTCL (EVL_IX_ARTCL_SN)
;


ALTER TABLE TB_EVL_MFCMM_DATA
	ADD FOREIGN KEY (EVL_IX_ARTCL_SN)
	REFERENCES TB_EVL_IX_ARTCL (EVL_IX_ARTCL_SN)
;


ALTER TABLE TB_EVL_MFCMM_DATA
	ADD FOREIGN KEY (EVL_IX_ARTCL_ALLOT_SN)
	REFERENCES TB_EVL_IX_ARTCL_ALLOT (EVL_IX_ARTCL_ALLOT_SN)
;



/* Comments */

COMMENT ON TABLE TB_EVL_IX IS '평가 지표 마스터 테이블';
COMMENT ON COLUMN TB_EVL_IX.EVL_IX_SN IS '평가지표 일련번호';
COMMENT ON COLUMN TB_EVL_IX.EVL_IX_YR IS '평가지표 연도';
COMMENT ON COLUMN TB_EVL_IX.EVL_IX_STEP IS '평가지표 평가단계';
COMMENT ON COLUMN TB_EVL_IX.REGI_ID IS '등록자';
COMMENT ON COLUMN TB_EVL_IX.REGI_DATE IS '등록일자';
COMMENT ON COLUMN TB_EVL_IX.UPDT_ID IS '수정자';
COMMENT ON COLUMN TB_EVL_IX.UPDT_DATE IS '수정일자';
COMMENT ON TABLE TB_EVL_IX_ARTCL IS '평가 지표 항목';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.EVL_IX_ARTCL_SN IS '평가지표항목 일련번호';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.EVL_IX_SN IS '평가지표 일련번호';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.UP_EVL_IX_ARTCL_SN IS '상위 평가지표항목 일련번호';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.ARTCL_NM IS '항목명';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.ADD_COL1 IS '추가컬럼1';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.ADD_COL2 IS '추가컬럼2';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.ADD_COL3 IS '추가컬럼3';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.ADD_COL4 IS '추가컬럼4';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.ADD_COL5 IS '추가컬럼5';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.USE_YN IS '사용여부';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.ADUP_YN IS '합산여부';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.REGI_ID IS '등록자';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.REGI_DATE IS '등록일자';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.UPDT_ID IS '수정자';
COMMENT ON COLUMN TB_EVL_IX_ARTCL.UPDT_DATE IS '수정일자';
COMMENT ON TABLE TB_EVL_IX_ARTCL_ALLOT IS '평가 지표 항목 배점';
COMMENT ON COLUMN TB_EVL_IX_ARTCL_ALLOT.EVL_IX_ARTCL_ALLOT_SN IS '평가지표항목배점 일련번호';
COMMENT ON COLUMN TB_EVL_IX_ARTCL_ALLOT.EVL_IX_ARTCL_SN IS '평가지표항목 일련번호';
COMMENT ON COLUMN TB_EVL_IX_ARTCL_ALLOT.ORDR IS '순서';
COMMENT ON COLUMN TB_EVL_IX_ARTCL_ALLOT.ALLOT_NM IS '배점명';
COMMENT ON COLUMN TB_EVL_IX_ARTCL_ALLOT.ALLOT_VL IS '배점값';
COMMENT ON COLUMN TB_EVL_IX_ARTCL_ALLOT.REGI_ID IS '등록자';
COMMENT ON COLUMN TB_EVL_IX_ARTCL_ALLOT.REGI_DATE IS '등록일자';
COMMENT ON COLUMN TB_EVL_IX_ARTCL_ALLOT.UPDT_ID IS '수정자';
COMMENT ON COLUMN TB_EVL_IX_ARTCL_ALLOT.UPDT_DATE IS '수정일자';
COMMENT ON TABLE TB_EVL_MFCMM_DATA IS '평가위원 데이터';
COMMENT ON COLUMN TB_EVL_MFCMM_DATA.EVL_MFCMM_DATA_SN IS '평가위원 데이터 일련번호';
COMMENT ON COLUMN TB_EVL_MFCMM_DATA.EVALU_HIST_SN IS '평가대상사업 이력 일련번호';
COMMENT ON COLUMN TB_EVL_MFCMM_DATA.EVL_IX_ARTCL_SN IS '평가지표항목 일련번호';
COMMENT ON COLUMN TB_EVL_MFCMM_DATA.EVL_IX_ARTCL_ALLOT_SN IS '평가지표항목배점 일련번호';
COMMENT ON COLUMN TB_EVL_MFCMM_DATA.DCS_OPNN IS '판단의견';
COMMENT ON COLUMN TB_EVL_MFCMM_DATA.IPM_NOTE IS '개선사항';
COMMENT ON COLUMN TB_EVL_MFCMM_DATA.REGI_ID IS '등록자';
COMMENT ON COLUMN TB_EVL_MFCMM_DATA.REGI_DATE IS '등록일자';
COMMENT ON COLUMN TB_EVL_MFCMM_DATA.UPDT_ID IS '수정자';
COMMENT ON COLUMN TB_EVL_MFCMM_DATA.UPDT_DATE IS '수정일자';

CREATE SEQUENCE TESSUSER.SEQ_EVL_IX_SN INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999 CYCLE NOCACHE NOORDER;
CREATE SEQUENCE TESSUSER.SEQ_EVL_IX_ARTCL_SN INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999 CYCLE NOCACHE NOORDER;
CREATE SEQUENCE TESSUSER.SEQ_EVL_IX_ARTCL_ALLOT_SN INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999 CYCLE NOCACHE NOORDER;
CREATE SEQUENCE TESSUSER.SEQ_EVL_MFCMM_DATA_SN INCREMENT BY 1 MINVALUE 1 MAXVALUE 999999 CYCLE NOCACHE NOORDER;

-- 평가지표 마스터 데이터 생성 (2023년 사전, 집행, 사후)
INSERT INTO TB_EVL_IX VALUES (SEQ_EVL_IX_SN.NEXTVAL, '2023', 'EVALU_PREV', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX VALUES (SEQ_EVL_IX_SN.NEXTVAL, '2023', 'EVALU_PROG', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX VALUES (SEQ_EVL_IX_SN.NEXTVAL, '2023', 'EVALU_AFTR', 'hblee', SYSDATE, NULL, NULL);

-- 2023년 사전진단 평가지표
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, NULL, '사업준비도', 1, NULL, NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 1, '사전행정 절차 이행여부', 2, NULL, NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 2, '부지확보 계획의 타당성', 3, '부지확보가 완료되지는 않았으나, 연중 부지확보 계획이 있는 경우 타당한지에 대하여 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 2, '관련 인허가 계획의 타당성', 3, '환경영향평가, 문화재심의 등 관련 인허가 계획이 있는 경우 타당한지에 대하여 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 1, '입지 적합성', 2, NULL, NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 5, '부지용도와 시설간의 부합성', 3, '토지용도에 맞는 시설 도입인지에 대한 법규 부합성 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 5, '대상지 접근성 수준', 3, '사업대상지 대중교통, 차량이용, 도보 접근성, 진출입로 확보 등 접근성 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 5, '대상지내 시설물 입지 적절성', 3, '사업부지 내 도입시설물 배치 및 동선 계획, 디자인 계획 등 시설물 도입 적합 여부 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 1, '운영 가능성 검토', 2, NULL, NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 9, '지역주민 참여활성화 방안 수립 여부', 3, '지역주민 설명회, 주민 참여도, 주민요구사업 등 사업에 대한 지역주민의 의지를 종합적으로 판단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 9, '지속운영 가능성', 3, '유료시설 및 프로그램의 수익 등 자체발생 수입으로 지속운영 가능여부와 공공예산의 지속 투입을 통해 유지가 필요한 사업인가에 대한 판단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);

INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, NULL, '내용 적정성', 1, NULL, NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 12, '사업내용 부합성', 2, NULL, NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 13, '상위 및 관련 계획과의 정합성', 3, '상위(유관)계획과의 연계성 진단(해당시)', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 13, '사업목적과 사업 내용의 부합성', 3, '사업목적 및 개발 콘셉트와 사업내용의 부합성 등 사업추진 당위성 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 12, '사업규모 적정성', 2, NULL, NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 16, '수요예측의 적정성', 3, '객관적인 관광수요의 추정 여부, 추정치의 적정 수준 여부 등 수요예측의 적정성 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 16, '예산규모 및 편성의 적정성', 3, '사업의 예산 항목 구성(토지보상비, 운영비 등) 및 예산 규모의 적정성 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 16, '수요대비 사업규모 적정성', 3, '수요예측을 바탕으로 사업의 규모가 적정한지 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 12, '사업 특화성', 2, NULL, NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 20, '관광콘텐츠의 매력성/독창성/차별성', 3, '핵심 관광콘텐츠의 존재 여부, 독창적 관광콘텐츠 발굴 여부 등 관광콘텐츠의 매력성 여부와 유사 및 경쟁시설과의 차별성 보유 및 사업의 독창성 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 20, '도입시설 간의 연계성', 3, '시설간 연계방안 및 프로그램 확충방안 등이 적정하게 마련되어 있는지 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 20, '지역관광 자원과의 연계성', 3, '지역 내 또는 인접 지역의 다른 관광자원과의 연계 및 상생발전가능성 진단', NULL, NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL VALUES (SEQ_EVL_IX_ARTCL_SN.NEXTVAL, 1, 1, '타 사업과의 중복 검토', 1, '인접 지역 또는 지역 내 동일/유사사업을 충실히 검토하였는지 여부와 유사사업과의 차별화 및 연계방안에 대한 고려 여부 확인', 'MINUS', NULL, NULL, NULL, 'Y', 'Y', 'hblee', SYSDATE, NULL, NULL);

INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 3, 1, '미확보', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 3, 2, '확보가능', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 3, 3, '확보', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 4, 1, '미흡', 1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 4, 2, '다소미흡', 2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 4, 3, '보통', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 4, 4, '다소우수', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 4, 5, '우수', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 6, 1, '미흡', 6, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 6, 2, '다소미흡', 7, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 6, 3, '보통', 8, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 6, 4, '다소우수', 9, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 6, 5, '우수', 10, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 7, 1, '미흡', 6, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 7, 2, '다소미흡', 7, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 7, 3, '보통', 8, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 7, 4, '다소우수', 9, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 7, 5, '우수', 10, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 8, 1, '미흡', 6, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 8, 2, '다소미흡', 7, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 8, 3, '보통', 8, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 8, 4, '다소우수', 9, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 8, 5, '우수', 10, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 10, 1, '미흡', 1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 10, 2, '다소미흡', 2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 10, 3, '보통', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 10, 4, '다소우수', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 10, 5, '우수', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 11, 1, '미흡', 1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 11, 2, '다소미흡', 2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 11, 3, '보통', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 11, 4, '다소우수', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 11, 5, '우수', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 14, 1, '미흡', 1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 14, 2, '다소미흡', 2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 14, 3, '보통', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 14, 4, '다소우수', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 14, 5, '우수', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 15, 1, '미흡', 1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 15, 2, '다소미흡', 2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 15, 3, '보통', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 15, 4, '다소우수', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 15, 5, '우수', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 17, 1, '미흡', 1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 17, 2, '다소미흡', 2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 17, 3, '보통', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 17, 4, '다소우수', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 17, 5, '우수', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 18, 1, '미흡', 1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 18, 2, '다소미흡', 2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 18, 3, '보통', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 18, 4, '다소우수', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 18, 5, '우수', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 19, 1, '미흡', 1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 19, 2, '다소미흡', 2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 19, 3, '보통', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 19, 4, '다소우수', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 19, 5, '우수', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 21, 1, '미흡', 11, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 21, 2, '다소미흡', 12, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 21, 3, '보통', 13, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 21, 4, '다소우수', 14, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 21, 5, '우수', 15, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 22, 1, '미흡', 1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 22, 2, '다소미흡', 2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 22, 3, '보통', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 22, 4, '다소우수', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 22, 5, '우수', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 23, 1, '미흡', 1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 23, 2, '다소미흡', 2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 23, 3, '보통', 3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 23, 4, '다소우수', 4, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 23, 5, '우수', 5, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 24, 1, '미흡', -3, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 24, 2, '', -2, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 24, 3, '', -1, 'hblee', SYSDATE, NULL, NULL);
INSERT INTO TB_EVL_IX_ARTCL_ALLOT VALUES (SEQ_EVL_IX_ARTCL_ALLOT_SN.NEXTVAL, 24, 4, '우수', 0, 'hblee', SYSDATE, NULL, NULL);