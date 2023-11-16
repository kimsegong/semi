-- 시퀀스 삭제
DROP SEQUENCE USER_SEQ;

DROP SEQUENCE PRODUCT_SEQ;
DROP SEQUENCE MOUNTAIN_SEQ;
DROP SEQUENCE REVIEW_SEQ;
DROP SEQUENCE IMAGE_SEQ;

DROP SEQUENCE MAGAZINE_SEQ;

DROP SEQUENCE RESERVE_SEQ;
DROP SEQUENCE TOURIST_SEQ;
DROP SEQUENCE PAY_SEQ;

DROP SEQUENCE INQUIRY_SEQ;
DROP SEQUENCE ANSWER_SEQ;
DROP SEQUENCE FAQ_SEQ;

DROP SEQUENCE NOTICE_SEQ;

-- 시퀀스 생성
CREATE SEQUENCE USER_SEQ NOCACHE;

CREATE SEQUENCE PRODUCT_SEQ NOCACHE;
CREATE SEQUENCE MOUNTAIN_SEQ NOCACHE;
CREATE SEQUENCE REVIEW_SEQ NOCACHE;
CREATE SEQUENCE IMAGE_SEQ NOCACHE;

CREATE SEQUENCE MAGAZINE_SEQ NOCACHE;

CREATE SEQUENCE RESERVE_SEQ NOCACHE;
CREATE SEQUENCE TOURIST_SEQ NOCACHE;
CREATE SEQUENCE PAY_SEQ NOCACHE;

CREATE SEQUENCE INQUIRY_SEQ NOCACHE;
CREATE SEQUENCE ANSWER_SEQ NOCACHE;
CREATE SEQUENCE FAQ_SEQ NOCACHE;

CREATE SEQUENCE NOTICE_SEQ NOCACHE;


-- 테이블 삭제
DROP TABLE NOTICE_T;

DROP TABLE FAQ_T;
DROP TABLE INQUIRY_ANSWER_T;
DROP TABLE INQUIRY_T;

DROP TABLE REVIEW_T;

DROP TABLE PAYMENT_T;
DROP TABLE TOURIST_T;
DROP TABLE RESERVE_T;

DROP TABLE MAGAZINE_STAR_T;
DROP TABLE MAGAZINE_MULTI_T;
DROP TABLE MAGAZINE_T;

DROP TABLE HEART_T;
DROP TABLE IMAGE_T;
DROP TABLE PRODUCT_T;
DROP TABLE MOUNTAIN_T;

DROP TABLE LEAVE_USER_T;
DROP TABLE ACCESS_T;
DROP TABLE USER_T;



--테이블

--**********************************************************************************

-- 가입한 사용자
CREATE TABLE USER_T (
    USER_NO        NUMBER              NOT NULL,        -- 회원번호 (PK)
    EMAIL          VARCHAR2(100 BYTE)  NOT NULL UNIQUE, -- 이메일을 아이디로 사용
    PW             VARCHAR2(64 BYTE),                   -- SHA-256 암호화 방식 사용
    NAME           VARCHAR2(50 BYTE),                   -- 이름
    GENDER         VARCHAR2(2 BYTE),                    -- M, F, NO
    MOBILE         VARCHAR2(15 BYTE),                   -- 하이픈 제거 후 저장
    POSTCODE       VARCHAR2(5 BYTE),                    -- 우편번호
    ROAD_ADDRESS   VARCHAR2(100 BYTE),                  -- 도로명주소
    JIBUN_ADDRESS  VARCHAR2(100 BYTE),                  -- 지번주소
    DETAIL_ADDRESS VARCHAR2(100 BYTE),                  -- 상세주소
    AGREE          NUMBER              NOT NULL,        -- 서비스 동의 여부(0:필수, 1:이벤트)
    STATE          NUMBER,                              -- (자동로그인)가입형태(0:정상, 1:네이버)
    AUTH           NUMBER,                              -- 사용자 권한 (관리자:0, 회원:1)
    PW_MODIFIED_AT DATE,                                -- 비밀번호 수정일
    JOINED_AT      DATE,                                -- 가입일
    CONSTRAINT PK_USER PRIMARY KEY(USER_NO)
);

-- 접속 기록
CREATE TABLE ACCESS_T (
    EMAIL    VARCHAR2(100 BYTE) NOT NULL,  -- 접속한 사용자 (FK)
    LOGIN_AT DATE,                         -- 로그인 일시
    CONSTRAINT FK_USER_ACCESS FOREIGN KEY(EMAIL) REFERENCES USER_T(EMAIL) ON DELETE CASCADE
);

-- 탈퇴한 사용자
CREATE TABLE LEAVE_USER_T (
    EMAIL     VARCHAR2(100 BYTE) NOT NULL,  -- 탈퇴한 사용자 이메일
    JOINED_AT DATE,                         -- 가입일
    LEAVED_AT DATE,                         -- 탈퇴일
    CONSTRAINT PK_LEAVE_USER PRIMARY KEY(EMAIL)
);


--**********************************************************************************

-- 산 테이블
CREATE TABLE MOUNTAIN_T (
	MOUNTAIN_NO	  NUMBER		     NOT NULL,  -- 산 번호 
	MOUNTAIN_NAME VARCHAR2(150 BYTE) NOT NULL,  -- 산이름
	IMPORMATION	  VARCHAR2(500 BYTE) NOT NULL,  -- 산정보 
	LOCATION	  VARCHAR2(100 BYTE) NOT NULL,  -- 산위치(ex 강원도, 제주도..)
    CONSTRAINT PK_MOUNTAIN_T PRIMARY KEY(MOUNTAIN_NO)
);

-- 여행지(상품) 테이블
CREATE TABLE PRODUCT_T(
   PRODUCT_NO     NUMBER             NOT NULL,  -- 상품 번호 
   USER_NO        NUMBER             NOT NULL,  -- 작성자(관리자) 번호
   MOUNTAIN_NO    NUMBER             NOT NULL,  -- 산 번호
   TRIP_NAME      VARCHAR2(255 BYTE) NOT NULL,  -- 여행이름(제목)
   TRIP_CONTENTS  CLOB               NULL,      -- 여행내용(설명)
   GUIDE          VARCHAR2(100 BYTE) NULL,      -- 가이드 정보
   TIMETAKEN      VARCHAR2(100 BYTE) NULL,      -- 여행일정(소요시간 ex 당일)
   PRICE          NUMBER             NULL,      -- 가격
   DANGER         VARCHAR2(500 BYTE) NULL,      -- 주의사항
   REGISTERED_AT  DATE               NULL,      -- 등록일
   MODIFIED_DATE  DATE               NULL,      -- 수정일
   PEOPLE         NUMBER             NULL,      -- 최대인원수
   HIT            NUMBER             DEFAULT 0, -- 조회수
   PLAN           VARCHAR2(255 BYTE) NULL,      -- 여행계획
   STATUS         NUMBER             NULL,      -- 상품상태 (예약가능:0, 예약불가:1)
   TERM_USE      VARCHAR2(500 BYTE)  NULL,      -- 이용약관 (동의체크X, 약관내용을 DB에 저장해놓는 용도)
   CONSTRAINT PK_PRODUCT PRIMARY KEY(PRODUCT_NO),
   CONSTRAINT FK_USER_PRODUCT     FOREIGN KEY(USER_NO)     REFERENCES USER_T(USER_NO)         ON DELETE CASCADE,
   CONSTRAINT FK_MOUNTAIN_PRODUCT FOREIGN KEY(MOUNTAIN_NO) REFERENCES MOUNTAIN_T(MOUNTAIN_NO) ON DELETE CASCADE
);



-- 상품사진첨부 테이블      
CREATE TABLE IMAGE_T(
    IMAGE_PATH        VARCHAR2(300 BYTE)  NOT NULL,  -- 첨부 사진 경로
    FILESYSTEM_NAME   VARCHAR2(300 BYTE)  NOT NULL,  -- 저장 파일명
    THUMBNAIL         NUMBER              NULL,      -- 썸네일이미지
    PRODUCT_NO        NUMBER              NOT NULL,  -- 상품 번호
    CONSTRAINT FK_PRODUCT_IMAGE FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE CASCADE
);

-- 상품 찜 
CREATE TABLE HEART_T ( 
	USER_NO	   NUMBER  NOT NULL,  -- 회원 번호
	PRODUCT_NO NUMBER  NOT NULL,  -- 상품 번호
    CONSTRAINT FK_USER_HEART    FOREIGN KEY(USER_NO)    REFERENCES USER_T(USER_NO)       ON DELETE CASCADE,
    CONSTRAINT FK_PRODUCT_HEART FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE CASCADE
);


--**********************************************************************************
-- 매거진 테이블
CREATE TABLE MAGAZINE_T (
    MAGAZINE_NO NUMBER	            NOT NULL,  -- 매거진 번호
    USER_NO	    NUMBER		        NOT NULL,  -- 회원 번호
    TITLE	    VARCHAR2(100 BYTE)  NOT NULL,  -- 매거진 제목
    CONTENTS	CLOB		        NOT NULL,  -- 매거진 내용
    SUMMARY     VARCHAR2(2000 BYTE) NULL,      -- (리스트용) 요약
    HIT	        NUMBER		        DEFAULT 0, -- 매거진 조회수
    CREATE_AT	DATE	            NULL,      -- 매거진 작성날짜
    PRODUCT_NO	NUMBER		        NOT NULL,  -- 상품 번호
    CONSTRAINT PK_MAGAZINE_NO PRIMARY KEY(MAGAZINE_NO),
    CONSTRAINT FK_USER_MAGAZIN    FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO)          ON DELETE SET NULL,
    CONSTRAINT FK_PRODUCT_MAGAZIN FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE SET NULL
);

-- 매거진 멀티미디어
CREATE TABLE MAGAZINE_MULTI_T (
	MAGAZINE_NO	 NUMBER	            NULL,  -- 매거진 번호
	MULTI_PATH	 VARCHAR2(100 BYTE) NULL,  -- 멀티미디어 경로
	FILESYS_NAME VARCHAR2(100 BYTE) NULL,  -- 파일 이름
    IS_THUMBNAIL NUMBER             NULL,  -- 썸네일로 쓰이는 사진 구분
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


-- 예약 테이블
CREATE TABLE RESERVE_T (
    RESERVE_NO      NUMBER              NOT NULL,   -- 예약번호(PK)
    RESERVE_DATE    DATE                NOT NULL,   -- 예약일
    REQUEST         VARCHAR2(4000 BYTE) NULL,       -- 요청사항
    AGREE           NUMBER              NOT NULL,   -- 0:필수동의, 1:선택까지동의
    PICKUP_LOC      VARCHAR2(100 BYTE)  NULL,       -- 버스 탑승지
    RESERVE_STATUS  NUMBER              DEFAULT 0,  -- 0:정상, 1:대기, 2:불가
    RESERVE_START   VARCHAR2(30 BYTE)   NULL,       -- 예약시작일
    RESERVE_PERSON  NUMBER              NULL,       -- 예약한 총 인원수
    USER_NO         NUMBER              NULL,       -- 유저번호(FK)
    PRODUCT_NO      NUMBER              NOT NULL,   -- 상품번호(FK)    
    CONSTRAINT PK_RES PRIMARY KEY(RESERVE_NO),
    CONSTRAINT FK_USER_RES FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE SET NULL,
    CONSTRAINT FK_PRODUCT_RES FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE CASCADE
);

-- 실제 여행자 테이블
CREATE TABLE TOURIST_T (
    TOURIST_NO   NUMBER             NOT NULL,     -- 실제 여행객 번호(PK)
    NAME         VARCHAR2(100 BYTE) NULL,         -- 이름
    BIRTH_DATE   VARCHAR2(30 BYTE)  NULL,         -- 생년월일
    GENDER       VARCHAR2(2 BYTE)   NULL,         -- 성별
    CONTACT      VARCHAR2(30 BYTE)  NULL,         -- 연락처
    AGE_CASE     NUMBER             NULL,         -- 0:성인, 1:소아, 2:유아
    RESERVE_NO   NUMBER             NOT NULL,     -- 예약번호
    CONSTRAINT PK_TOUR PRIMARY KEY(TOURIST_NO),
    CONSTRAINT FK_RES_TOUR FOREIGN KEY(RESERVE_NO) REFERENCES RESERVE_T(RESERVE_NO) ON DELETE CASCADE
);


-- 결제 테이블
CREATE TABLE PAYMENT_T (
    PAYMENT_NO   NUMBER             NOT NULL,  -- 결제번호(PK)
    PAY_YN       VARCHAR2(50 BYTE)  NULL,      -- 결제여부
    PAY_KIND     VARCHAR2(100 BYTE) NULL,      -- 결제방식
    PAY_BANK     VARCHAR2(100 BYTE) NULL,      -- 결제은행
    PAY_APPROVAL VARCHAR2(100 BYTE) NULL,      -- 결제승인
    PAY_DATE     VARCHAR2(100 BYTE) NULL,      -- 결제일
    RESERVE_NO   NUMBER             NULL,      -- 예약번호(FK)
    CONSTRAINT PK_PAY PRIMARY KEY(PAYMENT_NO),
    CONSTRAINT FK_RESERVE_PAY FOREIGN KEY(RESERVE_NO) REFERENCES RESERVE_T(RESERVE_NO) ON DELETE SET NULL
);


--*************************************상품 리뷰 테이블*********************************************

-- 리뷰 테이블
CREATE TABLE REVIEW_T (
	REVIEW_NO	NUMBER		       NOT NULL,  -- 리뷰번호
	PRODUCT_NO	NUMBER		       NOT NULL,  -- 상품번호
    RESERVE_NO  NUMBER             NOT NULL,  -- 예약번호
	USER_NO	    NUMBER		       NOT NULL,  -- 회원번호
	CONTENTS	VARCHAR2(300 BYTE) NULL,      -- 리뷰내용
	CREATED_AT	DATE		       NOT NULL,  -- 작성일
	MODIFIED_AT	DATE		       NOT NULL,  -- 수정일
	STATUS	    NUMBER             NOT NULL,  -- 댓글상태(삭제여부, 0:미삭제, 1:삭제)
	STAR	    NUMBER             NULL,      -- 별점
    CONSTRAINT PK_REVIEW PRIMARY KEY(REVIEW_NO),
    CONSTRAINT FK_USER_REVIEW FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE CASCADE,
    CONSTRAINT FK_PRODUCT_REVIEW FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE CASCADE,
    CONSTRAINT FK_RESERVE_REVIEW FOREIGN KEY(RESERVE_NO) REFERENCES RESERVE_T(RESERVE_NO) ON DELETE CASCADE
);


--**********************************************************************************

-- 문의하기 테이블
CREATE TABLE INQUIRY_T (
    INQUIRY_NO       NUMBER             NOT NULL,   -- 문의번호         (PK)
    USER_NO          NUMBER             NOT NULL,   -- 회원번호(작성자) (FK)
    PRODUCT_NO       NUMBER             NULL,       -- 상품번호         (FK)
    INQUIRY_TITLE    VARCHAR2(100 BYTE) NULL,       -- 제목
    INQUIRY_CONTENTS CLOB               NULL,       -- 내용
    IP               VARCHAR2(30 BYTE)  NULL,       -- IP주소
    CREATED_AT       DATE               NULL,       -- 작성일
    CONSTRAINT PK_INQUIRY PRIMARY KEY(INQUIRY_NO),
    CONSTRAINT FK_USER_INQUIRY FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE CASCADE,
    CONSTRAINT FK_PRODUCT_INQUIRY FOREIGN KEY(PRODUCT_NO) REFERENCES PRODUCT_T(PRODUCT_NO) ON DELETE SET NULL
);


-- 문의하기-답변 테이블
CREATE TABLE INQUIRY_ANSWER_T (
    ANSWER_NO   NUMBER             NOT NULL,   -- 답변번호           (PK)
    INQUIRY_NO  NUMBER             NOT NULL,   -- 문의번호           (FK)
    USER_NO     NUMBER             NULL,       -- 작성자(관리자)번호 (FK)
    CONTENTS    CLOB               NULL,       -- 내용
    CREATED_AT  DATE               NULL,       -- 작성일
    MODIFIED_AT DATE               NULL,       -- 수정일
    CONSTRAINT PK_ANSWER PRIMARY KEY(ANSWER_NO),
    CONSTRAINT FK_INQUIRY_ANSWER FOREIGN KEY(INQUIRY_NO) REFERENCES INQUIRY_T(INQUIRY_NO) ON DELETE CASCADE,
    CONSTRAINT FK_USER_ANSWER FOREIGN KEY(USER_NO) REFERENCES USER_T(USER_NO) ON DELETE SET NULL
);

-- 자주묻는질문 테이블
CREATE TABLE FAQ_T (
    FAQ_NO      NUMBER             NOT NULL,   -- 글번호  (PK)
    TITLE       VARCHAR2(100 BYTE) NULL,       -- 제목
    CONTENTS    CLOB               NULL,       -- 내용
    CREATED_AT  DATE               NULL,       -- 작성일
    MODIFIED_AT DATE               NULL,       -- 수정일
    CONSTRAINT PK_FAQ PRIMARY KEY(FAQ_NO)
);


--**********************************************************************************

-- 공지사항 테이블
CREATE TABLE NOTICE_T (
    NOTICE_NO       NUMBER               NOT NULL, -- 공지 번호
    TITLE           VARCHAR2(100 BYTE),            -- 공지 제목
    CONTENTS        CLOB,                          -- 공지 내용
    CREATED_AT      DATE,                          -- 공지 작성일
    MODIFIED_AT     DATE,                          -- 공지 수정일
    CONSTRAINT PK_NOTICE_T PRIMARY KEY(NOTICE_NO)
); 


--**********************************************************************************






--**********************************************************************************
-- 테스트 정보 등록


-- 관리자 등록
INSERT INTO USER_T (USER_NO, EMAIL, PW, NAME, AGREE, AUTH) VALUES(USER_SEQ.NEXTVAL, 'admin', STANDARD_HASH('1', 'SHA256'), '관리자admin', 0, 0);
INSERT INTO USER_T (USER_NO, EMAIL, PW, NAME, AGREE, AUTH) VALUES(USER_SEQ.NEXTVAL, 'master', STANDARD_HASH('1', 'SHA256'), '관리자master', 0, 0);
COMMIT;

-- 회원 등록
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user1@naver.com', STANDARD_HASH('1111', 'SHA256'), '사용자1', 'M', '01011111111', '11111', '디지털로', '가산동', '101동 101호', 0, 0, 1, TO_DATE('20231001', 'YYYYMMDD'), TO_DATE('20220101', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user2@naver.com', STANDARD_HASH('2222', 'SHA256'), '사용자2', 'F', '01022222222', '22222', '디지털로', '가산동', '102동 102호', 0, 0, 1, TO_DATE('20231002', 'YYYYMMDD'), TO_DATE('20220102', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user3@naver.com', STANDARD_HASH('3333', 'SHA256'), '사용자3', 'M', '01033333333', '33333', '디지털로', '가산동', '103동 103호', 0, 0, 1, TO_DATE('20231003', 'YYYYMMDD'), TO_DATE('20220103', 'YYYYMMDD'));
INSERT INTO USER_T VALUES(USER_SEQ.NEXTVAL, 'user4@naver.com', STANDARD_HASH('4444', 'SHA256'), '사용자4', 'F', '01044444444', '44444', '디지털로', '가산동', '104동 104호', 0, 0, 1, TO_DATE('20231004', 'YYYYMMDD'), TO_DATE('20220104', 'YYYYMMDD'));
COMMIT;

-- 산 등록
INSERT INTO MOUNTAIN_T VALUES(MOUNTAIN_SEQ.NEXTVAL, '지리산', '지리산에서 뻗어나온 등지리산', '전라도');
INSERT INTO MOUNTAIN_T VALUES(MOUNTAIN_SEQ.NEXTVAL, '설악산', '산림청 선정 100대 명산. 인기명산[2위]', '강원도 속초시 고성군');
INSERT INTO MOUNTAIN_T VALUES(MOUNTAIN_SEQ.NEXTVAL, '북한산', '산림청 선정 100대 명산. 인기명산[3위]', '서울특별시 도봉구');
INSERT INTO MOUNTAIN_T VALUES(MOUNTAIN_SEQ.NEXTVAL, '소백산', '산림청 선정 100대 명산. 인기명산[7위]', '충북 단양');
INSERT INTO MOUNTAIN_T VALUES(MOUNTAIN_SEQ.NEXTVAL, '한라산', '멋있음', '제주도');
COMMIT;

-- 여행상품 등록
INSERT INTO PRODUCT_T VALUES(PRODUCT_SEQ.NEXTVAL, 1, 1, '등지리산투어', '등지리산 올라갈거에요 재밌어요 산행이 최고에요 모두모두 예약하세요', '둘리', '당일', 1000, '등산복 착용하기!', TO_DATE('20231101', 'YYYYMMDD'), TO_DATE('20231101', 'YYYYMMDD'), 30, 0, NULL, 0, '이용약관내용...동의체크X');
INSERT INTO PRODUCT_T VALUES(PRODUCT_SEQ.NEXTVAL, 1, 2, '설악산투어', '대한민국 100대 명산에 도전하세요! 강원도 속초에서 출발합니다.', '또치', '당일', 10000, '등산배낭 필수!', TO_DATE('20231101', 'YYYYMMDD'), TO_DATE('20231101', 'YYYYMMDD'), 30, 0, NULL, 0, '이용약관내용...동의체크X');
INSERT INTO PRODUCT_T VALUES(PRODUCT_SEQ.NEXTVAL, 2, 3, '북한산투어', '서울 도봉구에 있는 북한산!', '마이콜', '당일', 5000, '등산화 신고오세요!', TO_DATE('20231101', 'YYYYMMDD'), TO_DATE('20231101', 'YYYYMMDD'), 25, 0, NULL, 0, '이용약관내용...동의체크X');
INSERT INTO PRODUCT_T VALUES(PRODUCT_SEQ.NEXTVAL, 2, 4, '소백산투어', '충북 단양의 명산! 1440m를 가이드가 시작부터 끝까지 함께 갑니다.', '희동이', '당일', 30000, '등산스틱 챙겨오세요!', TO_DATE('20231101', 'YYYYMMDD'), TO_DATE('20231101', 'YYYYMMDD'), 20, 0, NULL, 0, '이용약관내용...동의체크X');
COMMIT;

-- 문의 등록
INSERT INTO INQUIRY_T VALUES(INQUIRY_SEQ.NEXTVAL, 3, 1, '환불해주세요', '저 다른데 갈래요', NULL, TO_DATE('20231101', 'YYYYMMDD'));
INSERT INTO INQUIRY_T VALUES(INQUIRY_SEQ.NEXTVAL, 4, 2, '이게모에요', '어떻게 예약하나요?', NULL, TO_DATE('20231102', 'YYYYMMDD'));
INSERT INTO INQUIRY_T VALUES(INQUIRY_SEQ.NEXTVAL, 5, 2, '울랄라', '울랄랄랄ㄹ라', NULL, TO_DATE('20231104', 'YYYYMMDD'));
INSERT INTO INQUIRY_T VALUES(INQUIRY_SEQ.NEXTVAL, 6, 3, '우리집까지 데려다 주나요?', '데려다줘요', NULL, TO_DATE('20231105', 'YYYYMMDD'));
INSERT INTO INQUIRY_T VALUES(INQUIRY_SEQ.NEXTVAL, 6, 3, '빨리빨리빨리빨리', '답변줘요', NULL, TO_DATE('20231107', 'YYYYMMDD'));
COMMIT;

-- 문의 답변 등록
INSERT INTO INQUIRY_ANSWER_T VALUES(ANSWER_SEQ.NEXTVAL, 1, 1, '속히 새로운 상품으로 찾아뵙겠습니다.',  TO_DATE('20231101', 'YYYYMMDD'),TO_DATE('20231101', 'YYYYMMDD'));
INSERT INTO INQUIRY_ANSWER_T VALUES(ANSWER_SEQ.NEXTVAL, 2, 2, '상품 상세페이지에서 예약 가능합니다. 감사합니다.',  TO_DATE('20231102', 'YYYYMMDD'),TO_DATE('20231102', 'YYYYMMDD'));
COMMIT;

-- 자주묻는질문 등록
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '예약 취소는 어떻게 하나요?', '취소불가', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '예약 취소는 어떻게 하나요?', '취소불가', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '예약 취소는 어떻게 하나요?', '취소불가', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '예약 취소는 어떻게 하나요?', '취소불가', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '예약 취소는 어떻게 하나요?', '취소불가', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '예약 취소는 어떻게 하나요?', '취소불가', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '예약 취소는 어떻게 하나요?', '취소불가', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '무통장 입금 결제 확인은 어떻게 하나요?', '걍 우리 믿고 가시면 됩니다.', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '대인/소인 나이 기준이 어떻게 되나요?', '소인 : 만 12세 이하. 나머진 다 대인~', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '개인 예약 확인은 어디서 하나요?', '마이페이지를 보씨오', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '예약 취소는 어떻게 하나요?', '취소불가', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '현장 결제 방식이 어떻게 되나요?', '현장에서 결제하심 됩니다.', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '기초생활 수급자(의료/생계) 할인 관련 기준이 있나요?', '그런거 없어용~', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '기본적인 개인 준비물이 있나요?', '등산화, 등산복, 등산배낭, 등산스틱', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '개명 후 이름 변경은 어떻게 하나요?', '주민등록 초본과 개명확인서를 첨부하여 [회원 이메일, 개명 전 성함, 개명 후 성함, 전화번호]를 함께 적어서 admin@gmail.com(춘하추동 CS센터 이메일)으로 메일을 보내주시면 담당자 확인 후 처리해드리겠습니다. 이름 변경까지는 7일정도 소요될 수 있습니다. 감사합니다.', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '단체 예약 관련 문의는 어떻게 하나요?', '10명 이상 단체 예약 문의는 02-0000-0000(춘하추동 CS센터 전화번호)으로 연락 부탁드립니다. 감사합니다.', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
INSERT INTO FAQ_T VALUES(FAQ_SEQ.NEXTVAL, '회원가입은 어떻게 하나요?', '홈페이지 우측 상단에 회원가입 메뉴를 통해 진행하시면 됩니다.', TO_DATE('20231004', 'YYYYMMDD'),TO_DATE('20231004', 'YYYYMMDD'));
COMMIT;

-- 예약 등록
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '예약하기 어렵다', 0, '서울역', 0, '2023/11/11', 3, 1, 1);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '이건 요구사항입니다', 0, '동대문', 0, '2023/11/11', 2, 1, 1);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저4입니다', 0, '서울역', 0, '2023/11/11', 2, 4, 1);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '나는 유저2', 0, '동대문', 0, '2023/11/11', 2, 2, 1);
INSERT INTO RESERVE_T VALUES(RESERVE_SEQ.NEXTVAL, TO_DATE('20231004', 'YYYYMMDD'), '저는 유저3이다', 0, '동대문', 0, '2023/11/11', 2, 3, 1);
COMMIT;

-- 실제여행객
--예약번호1
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '이종혁', '19930212', 'M', '01011111111', 0, 1);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '홍초딩', '20131111', 'F', '01022222222', 1, 1);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '박초딩', '20131111', 'F', '01012341234', 1, 1);
--예약번호2
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동대장', '20131111', 'F', '01022223333', 0, 2);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '동동대장','20131111', 'M', '01044444444', 0, 2);
--예약번호3
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저4본인', '20131111', 'F', '01099999999', 0, 3);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저4동행','20131111', 'F', '01088888888', 0, 3);
--예약번호4
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2엄마', '19660101', 'F', '01098769876', 0, 4);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저2아빠','19660202', 'M', '01067896789', 0, 4);
--예약번호5
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저3형', '19900101', 'M', '01088888888', 0, 5);
INSERT INTO TOURIST_T VALUES(TOURIST_SEQ.NEXTVAL, '유저3동생', '19990101', 'M', '01088888888', 0, 5);
COMMIT;

-- 결제내역 
INSERT INTO PAYMENT_T VALUES(PAY_SEQ.NEXTVAL, 'Y', 'card', 'kookmin', '승인_어쩌구저쩌구', '20231004', 1);
INSERT INTO PAYMENT_T VALUES(PAY_SEQ.NEXTVAL, 'Y', 'card', 'WOORI', '승인_어쩌구저쩌구', '20231004', 2);
INSERT INTO PAYMENT_T VALUES(PAY_SEQ.NEXTVAL, 'Y', 'card', 'SHINHAN', '승인_어쩌구저쩌구', '20231004', 3);
COMMIT;

-- 공지사항 등록
INSERT INTO NOTICE_T VALUES(NOTICE_SEQ.NEXTVAL, '가산', '구디아카데미', TO_DATE('20100101','YYYY-MM-DD'), TO_DATE('20110101','YYYY-MM-DD')); 
INSERT INTO NOTICE_T VALUES(NOTICE_SEQ.NEXTVAL, '광명', '사거리'      , TO_DATE('20120101','YYYY-MM-DD'), TO_DATE('20130101','YYYY-MM-DD')); 
INSERT INTO NOTICE_T VALUES(NOTICE_SEQ.NEXTVAL, '가리', '봉',           TO_DATE('20140101','YYYY-MM-DD'), TO_DATE('20150101','YYYY-MM-DD')); 
INSERT INTO NOTICE_T VALUES(NOTICE_SEQ.NEXTVAL, '개봉', '사거리',       TO_DATE('20160101','YYYY-MM-DD'), TO_DATE('20170101','YYYY-MM-DD')); 
INSERT INTO NOTICE_T VALUES(NOTICE_SEQ.NEXTVAL, '부천', '성모병원',     TO_DATE('20180101','YYYY-MM-DD'), TO_DATE('20190101','YYYY-MM-DD')); 
COMMIT;

-- 탈퇴회원 등록
INSERT INTO LEAVE_USER_T VALUES('user123@gmail.com', TO_DATE('20100101','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user456@gmail.com', TO_DATE('20100102','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user789@gmail.com', TO_DATE('20100103','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user987@gmail.com', TO_DATE('20100110','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user654@gmail.com', TO_DATE('20011010','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user321@gmail.com', TO_DATE('20100923','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user147@gmail.com', TO_DATE('20230101','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user258@gmail.com', TO_DATE('20220103','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user369@gmail.com', TO_DATE('20101101','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user963@gmail.com', TO_DATE('20170801','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user852@gmail.com', TO_DATE('20180515','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
INSERT INTO LEAVE_USER_T VALUES('user741@gmail.com', TO_DATE('20200815','YYYY-MM-DD'), TO_DATE(SYSDATE,'YYYY-MM-DD'));
COMMIT;

-- 리뷰 등록
INSERT INTO REVIEW_T VALUES(REVIEW_SEQ.NEXTVAL, 1, 1, 3, '또 가고싶어요. 이런 상품 많이 만들어 주세요~', TO_DATE(SYSDATE, 'YYYY-MM-DD'), TO_DATE(SYSDATE, 'YYYY-MM-DD'), 0, 5); 
INSERT INTO REVIEW_T VALUES(REVIEW_SEQ.NEXTVAL, 1, 2, 3, '재밌었어요. 가이드 설명도 알차요~', TO_DATE(SYSDATE, 'YYYY-MM-DD'), TO_DATE(SYSDATE, 'YYYY-MM-DD'), 0, 5); 
INSERT INTO REVIEW_T VALUES(REVIEW_SEQ.NEXTVAL, 2, 3, 5, '힘둘다..', TO_DATE(SYSDATE, 'YYYY-MM-DD'), TO_DATE(SYSDATE, 'YYYY-MM-DD'), 0, 4); 
INSERT INTO REVIEW_T VALUES(REVIEW_SEQ.NEXTVAL, 2, 4, 3, '추억은 방울방울', TO_DATE(SYSDATE, 'YYYY-MM-DD'), TO_DATE(SYSDATE, 'YYYY-MM-DD'), 0, 5); 
INSERT INTO REVIEW_T VALUES(REVIEW_SEQ.NEXTVAL, 3, 5, 4, '엥 짱나~', TO_DATE(SYSDATE, 'YYYY-MM-DD'), TO_DATE(SYSDATE, 'YYYY-MM-DD'), 1, 3); 
INSERT INTO REVIEW_T VALUES(REVIEW_SEQ.NEXTVAL, 4, 3, 3, '아주 좋은 경험이었습니다.', TO_DATE(SYSDATE, 'YYYY-MM-DD'), TO_DATE(SYSDATE, 'YYYY-MM-DD'), 0, 5); 
INSERT INTO REVIEW_T VALUES(REVIEW_SEQ.NEXTVAL, 2, 5, 5, '멋지..네요..', TO_DATE(SYSDATE, 'YYYY-MM-DD'), TO_DATE(SYSDATE, 'YYYY-MM-DD'), 0, 4); 
INSERT INTO REVIEW_T VALUES(REVIEW_SEQ.NEXTVAL, 2, 5, 5, '우와아아ㅏㅏ아아악 긴댓글긴댓글긴댓글 우와아아ㅏㅏ아아악 긴댓글긴댓글긴댓글 우와아아ㅏㅏ아아악 긴댓글긴댓글긴댓글 우와아아ㅏㅏ아아악 긴댓글긴댓글긴댓글 우와아아ㅏㅏ아아악 긴댓글긴댓글긴댓글  ', TO_DATE(SYSDATE, 'YYYY-MM-DD'), TO_DATE(SYSDATE, 'YYYY-MM-DD'), 0, 4); 
COMMIT;



--**********************************************************************************
-- 쿼리 테스트
--**********************************************************************************

-- 조회
-- 문의 리스트
SELECT COUNT(*)
  FROM INQUIRY_T;

SELECT A.INQUIRY_NO, A.USER_NO, A.NAME, A.EMAIL, A.AUTH, A.PRODUCT_NO, A.INQUIRY_TITLE, A.INQUIRY_CONTENTS, A.IP, A.CREATED_AT
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY INQ.INQUIRY_NO DESC) AS RN, INQ.INQUIRY_NO, INQ.INQUIRY_TITLE, INQ.INQUIRY_CONTENTS, INQ.IP, INQ.CREATED_AT, U.USER_NO, U.NAME, U.AUTH, U.EMAIL, INQ.PRODUCT_NO
          FROM USER_T U RIGHT OUTER JOIN INQUIRY_T INQ 
            ON U.USER_NO = INQ.USER_NO) A
 WHERE A.RN BETWEEN 1 AND 10;
 
-- 문의 상세
SELECT INQ.INQUIRY_NO, INQ.INQUIRY_TITLE, INQ.INQUIRY_CONTENTS, INQ.IP, INQ.CREATED_AT
     , U.USER_NO, U.NAME, U.AUTH
     , PR.PRODUCT_NO, PR.TRIP_NAME
  FROM INQUIRY_T INQ RIGHT OUTER JOIN USER_T U
    ON U.USER_NO = INQ.USER_NO RIGHT OUTER JOIN PRODUCT_T PR
    ON PR.PRODUCT_NO = INQ.PRODUCT_NO
 WHERE INQ.INQUIRY_NO = 5;
 
-- 문의 삭제
DELETE 
  FROM INQUIRY_T
 WHERE INQUIRY_NO = 7;
 

-- 문의 검색 
-- 1) 검색 결과 개수
SELECT COUNT(*)
  FROM INQUIRY_T
 WHERE USER_NO LIKE '%' || '6' || '%';
-- 2) 검색 결과 목록
SELECT A.INQUIRY_NO, A.PRODUCT_NO, A.INQUIRY_TITLE, A.INQUIRY_CONTENTS, A.IP, A.CREATED_AT, A.USER_NO, A.NAME
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY INQUIRY_NO DESC) AS RN, INQ.INQUIRY_NO, INQ.PRODUCT_NO, INQ.INQUIRY_TITLE, INQ.INQUIRY_CONTENTS, INQ.IP, INQ.CREATED_AT, U.USER_NO, U.NAME
          FROM USER_T U LEFT OUTER JOIN INQUIRY_T INQ
            ON INQ.USER_NO = U.USER_NO
         WHERE NAME LIKE '%' || '사용자' || '%') A
 WHERE A.RN BETWEEN 1 AND 10;

-- 답변 유무 확인
SELECT AN.ANSWER_NO, AN.CONTENTS, AN.CREATED_AT, AN.MODIFIED_AT, AN.USER_NO, INQ.INQUIRY_NO
  FROM INQUIRY_T INQ LEFT OUTER JOIN INQUIRY_ANSWER_T AN
    ON INQ.INQUIRY_NO = AN.INQUIRY_NO;

-- 답변 상세
SELECT AN.ANSWER_NO, AN.CONTENTS, AN.CREATED_AT, AN.MODIFIED_AT, INQ.INQUIRY_NO, U.USER_NO
  FROM INQUIRY_ANSWER_T AN RIGHT OUTER JOIN INQUIRY_T INQ
    ON INQ.INQUIRY_NO = AN.INQUIRY_NO LEFT OUTER JOIN USER_T U
    ON AN.USER_NO = U.USER_NO
 WHERE INQ.INQUIRY_NO = 2;
    


-- 답변 리스트
SELECT COUNT(*)
  FROM INQUIRY_ANSWER_T;

SELECT ROW_NUMBER() OVER(ORDER BY ANSWER_NO DESC) AS RN, ANSWER_NO, INQUIRY_NO, USER_NO, CONTENTS, CREATED_AT, MODIFIED_AT
  FROM INQUIRY_ANSWER_T;


 
-- 답변 수정
UPDATE INQUIRY_ANSWER_T
   SET CONTENTS = '환불 되지 않았습니다'
     , USER_NO = 1
     , MODIFIED_AT = SYSDATE
 WHERE ANSWER_NO = 1;

-- 답변 삭제
DELETE 
  FROM INQUIRY_ANSWER_T
 WHERE ANSWER_NO = 5;

COMMIT;


-- 자주묻는질문 리스트
-- 1) 결과 개수
SELECT COUNT(*)
  FROM FAQ_T;

-- 2) 결과 목록
SELECT FAQ_NO, TITLE, CONTENTS, CREATED_AT, MODIFIED_AT
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY FAQ_NO DESC) AS RN, FAQ_NO, TITLE, CONTENTS, CREATED_AT, MODIFIED_AT
          FROM FAQ_T)
 WHERE RN BETWEEN 1 AND 10;

-- 자주묻는질문 상세
SELECT FAQ_NO, TITLE, CONTENTS, CREATED_AT, MODIFIED_AT
  FROM FAQ_T
 WHERE FAQ_NO = 1;

-- 자주묻는질문 검색 
--1) 검색 개수
SELECT COUNT(*)
  FROM FAQ_T
 WHERE TITLE LIKE '%' || '단체' || '%';
-- 2) 검색목록
SELECT FAQ_NO, TITLE, CONTENTS, CREATED_AT, MODIFIED_AT
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY FAQ_NO DESC) AS RN, FAQ_NO, TITLE, CONTENTS, CREATED_AT, MODIFIED_AT
          FROM FAQ_T
         WHERE TITLE LIKE '%' || '단체' || '%')
 WHERE RN BETWEEN 1 AND 10;
 


-- 자주묻는질문 수정
UPDATE FAQ_T
   SET TITLE = '개명관련'
     , CONTENTS = '테스트'
     , MODIFIED_AT = SYSDATE
 WHERE FAQ_NO = 1;

-- 자주묻는질문 삭제
DELETE
  FROM FAQ_T
 WHERE FAQ_NO = 1;




-- 회원관리
-- 회원 목록
SELECT COUNT(*)
  FROM USER_T;

SELECT USER_NO, EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, STATE, AUTH, PW_MODIFIED_AT, JOINED_AT
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY USER_NO DESC) AS RN, USER_NO, EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, STATE, AUTH, PW_MODIFIED_AT, JOINED_AT
          FROM USER_T)
 WHERE RN BETWEEN 1 AND 10;

-- 회원 검색
SELECT COUNT(*)
  FROM USER_T
 WHERE NAME LIKE '%' || '사용' || '%';

SELECT USER_NO, EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, STATE, AUTH, PW_MODIFIED_AT, JOINED_AT
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY USER_NO DESC) AS RN, USER_NO, EMAIL, PW, NAME, GENDER, MOBILE, POSTCODE, ROAD_ADDRESS, JIBUN_ADDRESS, DETAIL_ADDRESS, AGREE, STATE, AUTH, PW_MODIFIED_AT, JOINED_AT
          FROM USER_T
         WHERE EMAIL LIKE '%' || '1' || '%')
 WHERE RN BETWEEN 1 AND 10;
 
-- 탈퇴 회원 목록
SELECT COUNT(*)
  FROM LEAVE_USER_T;

SELECT EMAIL, JOINED_AT, LEAVED_AT
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY LEAVED_AT DESC) AS RN, EMAIL, JOINED_AT, LEAVED_AT
          FROM LEAVE_USER_T)
 WHERE RN BETWEEN 1 AND 10;
 
-- 탈퇴 회원 검색
SELECT COUNT(*)
  FROM LEAVE_USER_T
 WHERE EMAIL LIKE '%' || 'user' || '%';

SELECT EMAIL, JOINED_AT, LEAVED_AT
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY LEAVED_AT DESC) AS RN, EMAIL, JOINED_AT, LEAVED_AT
          FROM LEAVE_USER_T
         WHERE EMAIL LIKE '%' || 'user' || '%')
 WHERE RN BETWEEN 1 AND 10;



-- 여행상품 목록
SELECT COUNT(*)
  FROM PRODUCT_T;
  
SELECT PRODUCT_NO, USER_NO, MOUNTAIN_NO, TRIP_NAME, TRIP_CONTENTS, GUIDE, TIMETAKEN, PRICE, DANGER, REGISTERED_AT, MODIFIED_DATE, PEOPLE, HIT, PLAN, STATUS, TERM_USE
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY PRODUCT_NO DESC) AS RN, PRODUCT_NO, USER_NO, MOUNTAIN_NO, TRIP_NAME, TRIP_CONTENTS, GUIDE, TIMETAKEN, PRICE, DANGER, REGISTERED_AT, MODIFIED_DATE, PEOPLE, HIT, PLAN, STATUS, TERM_USE
          FROM PRODUCT_T)
 WHERE RN BETWEEN 1 AND 10;
  
-- 여행상품 검색
SELECT COUNT(*)
  FROM PRODUCT_T
 WHERE PRODUCT_NO LIKE '%' || '2' || '%';

SELECT PRODUCT_NO, USER_NO, MOUNTAIN_NO, TRIP_NAME, TRIP_CONTENTS, GUIDE, TIMETAKEN, PRICE, DANGER, REGISTERED_AT, MODIFIED_DATE, PEOPLE, HIT, PLAN, STATUS, TERM_USE
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY PRODUCT_NO DESC) AS RN, PRODUCT_NO, USER_NO, MOUNTAIN_NO, TRIP_NAME, TRIP_CONTENTS, GUIDE, TIMETAKEN, PRICE, DANGER, REGISTERED_AT, MODIFIED_DATE, PEOPLE, HIT, PLAN, STATUS, TERM_USE
          FROM PRODUCT_T
         WHERE PRODUCT_NO LIKE '%' || '2' || '%')
 WHERE RN BETWEEN 1 AND 10;


-- 예약 관리 상세


-- 전체 리뷰 목록
SELECT COUNT(*)
  FROM REVIEW_T;

SELECT A.REVIEW_NO, A.PRODUCT_NO, A.RESERVE_NO, A.CONTENTS, A.CREATED_AT, A.MODIFIED_AT, A.STATUS, A.STAR, A.USER_NO, A.NAME
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY REVIEW_NO DESC) AS RN, RE.REVIEW_NO, RE.PRODUCT_NO, RE.RESERVE_NO, RE.CONTENTS, RE.CREATED_AT, RE.MODIFIED_AT, RE.STATUS, RE.STAR, U.USER_NO, U.NAME
          FROM USER_T U INNER JOIN REVIEW_T RE
            ON U.USER_NO = RE.USER_NO) A
 WHERE A.RN BETWEEN 1 AND 10;

-- 리뷰 검색
SELECT COUNT(*)
  FROM USER_T U INNER JOIN REVIEW_T RE
    ON U.USER_NO = RE.USER_NO
 WHERE REVIEW_NO LIKE '%' || '2' || '%';

SELECT A.REVIEW_NO, A.PRODUCT_NO, A.RESERVE_NO, A.CONTENTS, A.CREATED_AT, A.MODIFIED_AT, A.STATUS, A.STAR, A.USER_NO, A.NAME
  FROM (SELECT ROW_NUMBER() OVER(ORDER BY REVIEW_NO DESC) AS RN, RE.REVIEW_NO, RE.PRODUCT_NO, RE.RESERVE_NO, RE.CONTENTS, RE.CREATED_AT, RE.MODIFIED_AT, RE.STATUS, RE.STAR, U.USER_NO, U.NAME
          FROM USER_T U INNER JOIN REVIEW_T RE
            ON U.USER_NO = RE.USER_NO
         WHERE REVIEW_NO LIKE '%' || '2' || '%') A
 WHERE A.RN BETWEEN 1 AND 10;