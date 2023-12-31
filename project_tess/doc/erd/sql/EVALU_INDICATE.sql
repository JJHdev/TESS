
/* Drop Tables */

DROP TABLE TB_EVL_MFCMM_DATA CASCADE CONSTRAINTS;
DROP TABLE TB_EVL_IX_ARTCL_ALLOT CASCADE CONSTRAINTS;
DROP TABLE TB_EVL_IX_ARTCL CASCADE CONSTRAINTS;
DROP TABLE TB_EVL_IX CASCADE CONSTRAINTS;




/* Create Tables */

-- 평가 지표 마스터 테이블
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
	EVL_IX_ARTCL_ALLOT_SN number NOT NULL UNIQUE,
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
	EVALU_HIST_SN number,
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



