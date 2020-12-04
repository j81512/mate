----------------------
### 프로젝트명 : MATE
### [Site 바로가기](park.jh92.kro.kr/mate)
----------------------

### Sample ID 및 Password
> 일반 회원 : suzy / 1234 (쇼핑몰만 이용가능) <br>
> 관리자 : amin / 1234 (쇼핑몰 및 ERP 이용가능) <br>
> 지점 : toy1 / 1234 (ERP만 이용가능) <br>
> 제조사 : alter / 1234 (ERP만 이용가능) <br>

--- 

### 개발 환경
**O/S :** Windows 10 <br>
**Server :** Apache Tomcat 8.5 <br>
**DB :** Oracle <br>
**Language :** Java, SQL, HTML5, CSS3, JavaScript <br>
**IDE :** Spring Tool Suite 4, SQL Developer <br>

---

### 핵심 기능 (작성자가 구현한 기능만 코드 설명)
- Index 페이지의 Best 5 상품 추천 기능
&nbsp;&nbsp;&nbsp;&nbsp;
<details><summary>코드 보기</summary>
```jsp
asd
```
</details>

- 장바구니를 통한 여러 상품 구매 기능
- 구매자들의 배송지 관리 기능
- 구매내역 확인 및 상품 환불 및 교환 기능
- 지점별 매출/입출고/재고/발주 관리 기능
- ERP게시판을 통한 지점간의 상품 교환 기능
- 유저의 각종 문의 및 건의, 관리자의 공지사항 및 답변을 위한 고객센터
- open API를 사용한 로그인, 결제, 매장 위치확인, 상품 정보 입력, 핸드폰 인증 기능 <br>
  (kakao login, kakao map, daum 주소, naver login, ckeditor, coolsms, iamport 사용)
  
---

### 주요 테이블  
  
+ MEMBER ( 쇼핑몰 회원 관리 테이블 )
  + 쇼핑몰 회원 정보가 관리되는 테이블
  + MEMBER_ID COLUMN을 Primary key로 사용
  
+ EMP ( 관리자 회원 관리 테이블 )
  + ERP 시스템 사용자 정보가 관리되는 테이블
  + EMP_ID COLUMN을 Primary key로 사용
  + STATUS값으로 지점, 제조사, admin회원을 구분할 수 있다. ( 0 = admin, 1 = 지점, 2 = 제조사 )
  
+ PRODUCT ( 상품 정보 관리 테이블 )
  + 취급 상품 정보가 관리되는 테이블
  + PRODUCT_NO COLUMN을 Primary key로 사용
  + ENABLED COLUMN값으로 판매 상태를 결정하도록 한다. ( '0'일 경우 판매, '1'일 경우 판매 중지)
  
+ STOCK ( 상품 재고 관리 테이블 )
  + 각 지점 별 취급 상품의 재고를 관리하는 테이블
  + 각 지점에서 판매를 원하는 상품을 발주시 해당 테이블에 상품의 정보가 입력되며 재고 관리가 가능하게된다.
  + PRODICT_ID와 EMP_ID를 Primary key로 사용
  
+ REQUEST_LOG ( 발주 요청 관리 테이블 )
  + 지점에서 신청한 발주 요청을 관리하는 테이블
  + REQUEST_NO COLUMN을 Primary key로 사용
  + 제조사 회원이 발주 승인시 CONFIRM COLUMN 값이 '1'로 update되며 동시에 입고 로그 테이블에 해당 상품 정보가 입력되는 Trigger가 실행된다.
 
+ RECEIVE ( 입고 요청 관리 테이블 )
  + 제조사 회원이 발주 요청 승인 시, 실행되는 Trigger에 의해 입고 요청 정보가 입력되는 테이블
  + RECEIVE_NO COLUMN을 Primary key로 사용
  + 지점 회원이 입고 요청 목록을 확인 후, 승인 시 CONFIRM COLUMN 값이 '1'로 update되며 입출고 로그 테이블에 기록되는 Trigger가 실행된다.   
   입출고 로그 테이블에 입력이 감지되면 그 상태값이 'I'일 경우, 해당 상품과 지점 정보를 통해 상품 재고 테이블의 재고를 update는 Trigger가 실행되며 재고 관리가 가능하다.
  
--- 

