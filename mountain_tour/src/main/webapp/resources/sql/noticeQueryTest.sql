DROP SEQUENCE NOTICE_SEQ;

CREATE SEQUENCE NOTICE_SEQ NOCACHE;

DROP TABLE NOTICE_T;


CREATE TABLE NOTICE_T (
    NOTICE_NO       NUMBER               NOT NULL, -- 공지 번호
    TITLE           VARCHAR2(100 BYTE),            -- 공지 제목
    CONTENTS        CLOB,                          -- 공지 내용
    CREATED_AT      DATE,                          -- 공지 작성일
    MODIFIED_AT     DATE,                          -- 공지 수정일
    HIT             NUMBER,                        -- 조회수
    CONSTRAINT PK_NOTICE_T PRIMARY KEY(NOTICE_NO)
    ); 


-- 공지사항 삽입
INSERT INTO NOTICE_T VALUES(NOTICE_SEQ.NEXTVAL, '가산', '구디아카데미', TO_DATE('20100101','YYYY-MM-DD'), TO_DATE('20110101','YYYY-MM-DD'), 1); 
INSERT INTO NOTICE_T VALUES(NOTICE_SEQ.NEXTVAL, '광명', '사거리'      , TO_DATE('20120101','YYYY-MM-DD'), TO_DATE('20130101','YYYY-MM-DD'), 2); 
INSERT INTO NOTICE_T VALUES(NOTICE_SEQ.NEXTVAL, '가리', '봉',           TO_DATE('20140101','YYYY-MM-DD'), TO_DATE('20150101','YYYY-MM-DD'), 3); 
INSERT INTO NOTICE_T VALUES(NOTICE_SEQ.NEXTVAL, '개봉', '사거리',       TO_DATE('20160101','YYYY-MM-DD'), TO_DATE('20170101','YYYY-MM-DD'), 4); 
INSERT INTO NOTICE_T VALUES(NOTICE_SEQ.NEXTVAL, '부천', '성모병원',     TO_DATE('20180101','YYYY-MM-DD'), TO_DATE('20190101','YYYY-MM-DD'), 5); 

-- 공지사항 업데이트
UPDATE NOTICE_T
   SET TITLE = '광사'
 WHERE NOTICE_NO = 1;

UPDATE NOTICE_T
   SET TITLE = '김천'
 WHERE NOTICE_NO = 2;

-- 공지사항 조회
 SELECT *
   FROM NOTICE_T;
 
 SELECT NOTICE_NO, TITLE, CONTENTS, CREATED_AT, MODIFIED_AT, HIT
   FROM NOTICE_T
  WHERE TITLE LIKE '광' || '%';
  
 SELECT NOTICE_NO, TITLE, CONTENTS, CREATED_AT, MODIFIED_AT, HIT
   FROM NOTICE_T
  WHERE TITLE LIKE '개' || '%';
 

-- 공지사항 삭제 
 DELETE
   FROM NOTICE_T
  WHERE HIT = 5;