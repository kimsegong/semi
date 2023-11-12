

DROP SEQUENCE MAGAZINE_SEQ;

-- 시퀀스 생성


CREATE SEQUENCE MAGAZINE_SEQ NOCACHE;


-- 테이블 삭제

DROP TABLE MAGAZINE_STAR_T;
DROP TABLE MAGAZINE_MULTI_T;
DROP TABLE MAGAZINE_T;

--테이블


--**********************************************************************************

-- 매거진 테이블
CREATE TABLE MAGAZINE_T (
    MAGAZINE_NO NUMBER	           NOT NULL,  -- 매거진 번호
    USER_NO	    NUMBER		       NOT NULL,  -- 회원 번호
    TITLE	    VARCHAR2(100 BYTE) NOT NULL,  -- 매거진 제목
    CONTENTS	CLOB		       NOT NULL,  -- 매거진 내용
    SUMMARY     VARCHAR2(400 BYTE) NULL,      -- (리스트용) 요약
    HIT	        NUMBER		       DEFAULT 0, -- 매거진 조회수
    CREATE_AT	DATE	           NULL,      -- 매거진 작성날짜
    PRODUCT_NO	NUMBER		       NOT NULL,  -- 상품 번호
    CONSTRAINT PK_MAGAZINE_NO PRIMARY KEY(MAGAZINE_NO),
    CONSTRAINT FK_USER_MAGAZIN FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE SET NULL,
    CONSTRAINT FK_PRODUCT_MAGAZIN FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE SET NULL
);

-- 매거진 멀티미디어
CREATE TABLE MAGAZINE_MULTI_T (
	MAGAZINE_NO	 NUMBER	       NOT NULL,  -- 매거진 번호
	MULTI_PATH	 VARCHAR2(100 BYTE) NULL, -- 멀티미디어 경로
	FILESYS_NAME VARCHAR2(100 BYTE) NULL, -- 파일 이름
    IS_THUMBNAIL NUMBER             NULL, -- 썸네일로 쓰이는 사진 구분
  CONSTRAINT FK_MAGAZINE_MULTI FOREIGN KEY(MAGAZINE_NO) REFERENCES MAGAZINE_T(MAGAZINE_NO) ON DELETE SET NULL  
);

-- 매거진 좋아요 
CREATE TABLE MAGAZINE_STAR_T (
  MAGAZINE_NO NUMBER NOT NULL,  -- 매거진 번호
  USER_NO	  NUMBER NOT NULL,  -- 회원 번호
  CONSTRAINT FK_MAGAZINE_STAR FOREIGN KEY(MAGAZINE_NO) REFERENCES MAGAZINE_T(MAGAZINE_NO) ON DELETE CASCADE,
  CONSTRAINT FK_USER_STAR FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE SET NULL
);


--**********************************************************************************
