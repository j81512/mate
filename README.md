finalproject  
작성자 : 김 종완

----------------------
### 프로젝트명 : MATE
##### 조원 :  박준혁 김가영 김종완 김찬희 박도균 이호근 
----------------------

### 프로젝트 기획 이유
> 쇼핑몰이나 음식점및 기업체 등 상품을 다루는 곳에서는 재고를 관리할 수 있는 시스템이 필수적이다.  
> 상품 관리가 가능한 ERP시스템을 구축하고, 지점과 제조사간 소통이 가능한 게시판을 만들어 재고의 순환을 더욱 윤활하게 만들기 원했다.  
> 또한 '키덜트'시장을 겨냥한 쇼핑몰을 구추하고 구현된 ERP시스템을 연동하여 온라인, 오프라인 쇼핑몰의 소통 및 재고관리를 진행하도록 하였다.
-----------------------

### 개발 환경
 
+ 운영 체제 : Window 10
+ 언어 : Java / Javascript / HTML5 / CSS3 / SQL
+ IDE : Sping Tool Suite 4
+ DB : Oracle
+ Server : Apache tomcat 8.5
+ Framework / Platform : Maven / Mybatis / Spring framework / Spring security / commons-io

-----------------------


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
-----------------------

### 이 외 테이블
  
+ BOARD ( ERP 내 게시판 )
+ CS ( 쇼핑몰 내 고객센터 ) 
+ CART ( 쇼핑몰 장바구니 )
+ ADDRESS ( 배송지 )
+ PURCHASE ( 쇼핑몰 구매상품 )
+ PURCHASE_LOG ( 쇼핑몰 구매 로그 )
+ RETURN ( 환불 신청 상품 ) 등
  
-----------------------

### 주요 기능  (해당 부분은 작성자 본인이 구현한 기능 위주로 작성되었습니다.)
  
+ 쇼핑몰 상품구매 및 장바구니 추가
  + 쇼핑몰 상품리스트에서 구매를 원하는 상품 클릭 시, 해당 상품의 Product_no를 참조하여 productDetail.jsp로 이동하게된다.  
    해당 jsp에서 수량을 선택 후, '장바구니'클릭 시 ProductController의 saveCart메소드로 입력 정보가 제출되며, '구매하기' 클릭 시 purchaseProduct메소드로 입력 정보가 제출된다.  
  + 장바구니 입력 시, 상품 저장 후 쇼핑을 계속 이어나갈 수 있으며, 구매하기 클릭 시 결제 창으로 바로 안내받도록 되어있다.
  ```java
      //장바구니 클릭 시 안내되는 주소
      return "redirect:/product/productDetail.do?productNo=" + productNo;
      //구매하기 클릭 시
      return "redirect:/product/selectCart.do?memberId=" + memberId;
  ```
  
+ 발주 요청 처리
  + '발주 관리' 메뉴는 관리자의 상태값이 제조사인 회원에게만 노출된다. 해당 메뉴 진입 시 현재 로그인되어있는 관리자의 Id를 참조하여 requestList.jsp로 이동하게된다.  
    해당 페이지는 해당 제조사로 들어온 발주 요청들이 조회되며, 요청에 대해 발주 승인과 발주 거부를 선택할 수있다.  
    요청 승인 선택 시 ErpController의 appRequest메소드로 연결되며 요청의 confirm값이 '1'로 업데이트 된다.  
    요청 거부 선택 시 refRequest메소드로 연결되며 confirm값이 '-1'로 업데이트 된다. 요청 처리는 비동기 방식(ajax)으로 처리된다.
  + 해당 페이지는 한 페이지당 5개의 값을 노출할 수 있도록 페이징 처리가 되어있다.
  + 발주 테이블 CONFIRM 컬럼 업데이트 시 입고 테이블 insert Trigger
  ```sql
  create or replace trigger trg_request_log
    before
    update on request_log
    for each row
  begin
    if :new.confirm = 1 then
        insert into
            receive
        values(
            seq_receive_no.nextval,
            :new.manufacturer_id,
            :new.amount,
            default,
            default,
            :new.product_no,
            :new.emp_id
        );
    end if;
  end;
  /
  ```
+ 입고 요청 처리
  + '입고 관리' 메뉴는 관리자의 상태값이 지점과 admin(온라인지점)회원에게만 노출된다. 해당 메뉴 진입 시, 로그인 되어있는 관리자의 Id를 참조하여 receiveList.jsp로 이동하게된다.  
    해당 페이지는 발주 요청이 승인되어 입고 테이블에 작성되어진 상품들의 목록을 조회하며, 입고 승인 및 거부를 선택할 수 있다.  
    요청 승인 선택 시 ErpController의 appReceive메소드로 연결되며 요청의 confirm값이 '1'로 업데이트 된다.  
    요청 거부 선택 시 refReceive메소드로 연결되며 confirm값이 '-1'로 업데이트된다. 요청 처리는 비동기 방식(ajax)으로 처리된다.
  + 입고 테이블 CONFIRM 컬럼 업데이트 시 IO_LOG 테이블 insert Trigger  
  ```sql
  create or replace trigger trg_receive
    before
    update on receive
    for each row
  declare
    v_emp_name emp.emp_name%type;
  begin
    if :new.confirm = 1 then
        select
            emp_name
        into
            v_emp_name
        from
            emp
        where
            emp_id = :new.manufacturer_id;
        insert into
            io_log
        values(
            seq_io_no.nextval,
            'I',
            :new.amount,
            default,
            :new.product_no,
            :new.emp_id,
            v_emp_name || ' - 입고'
        );
    end if;
  end;
  /
  ```  
  IO_LOG테이블의 STATUS값이 'I'로 입력되었을 때 STOCK테이블에 재고 update Trigger (해당 트리거는 전체 모든 재고를 관리하는 트리거)
  ```sql
  create or replace trigger trg_io_log
    before
    insert on io_log
    for each row
  begin
    if :new.status = 'I' then
      update
          stock
      set
          stock = stock + :new.amount
      where
          product_no = :new.product_no and
          emp_id = :new.emp_id;
    end if;
      if :new.status = 'O' then
         update
          stock
      set
          stock = stock - :new.amount
      where
          product_no = :new.product_no and
          emp_id = :new.emp_id;
    end if;
  end;
  /
  ```
  
+ 상품 추가 ( CKeditor 적용 )
  + 새 상품을 추가하는 기능은 관리자의 상태값이 'admin'인 회원에게만 제공되는 기능이다. '상품 관리' 메뉴로 진입 시 searchInfo.jsp로 안내받게 되며 해당 메뉴에서는 현재 등록되어있는 모든 상품을 확인 할 수있고, 로그인 되어있는 지점의 상품 재고 또한 확인 할 수 있다.  
  해당 페이지 좌측 상단 '상품등록'버튼 클릭 시 productEnroll.jsp로 안내받게 되며 상품을 등록할 수 있는 form을 제공받는다.
  + jsp를 통해 입력될 상품의 이름, 카테고리, 섬네일사진, 내용, 가격, 제조사를 입력받게된다.
  + 이 때 내용은 Ckeditor를 통해 입력받도록 API를 적용시켜두었으며, 본문에 들어갈 이미지는 별도의 테이블에 보관된다.  
  CKeditor를 통해 이미지 업로드 시, 우선 서버의 temp폴더에 파일을 저장하도록 
  ```java
  @RequestMapping(value = "/imageFileUpload.do", method = RequestMethod.POST)
	@ResponseBody
	public String fileUpload(HttpServletRequest request, HttpServletResponse response,
							 MultipartHttpServletRequest multiFile) throws Exception {
		request.setCharacterEncoding("utf-8");
		JsonObject json = new JsonObject();
		PrintWriter printWriter = null;
		OutputStream out = null;
		MultipartFile file = multiFile.getFile("upload");
		
		//파일이 넘어왔을 경우
		if(file != null) {
			if(file.getSize() > 0 ) {
				//이미지 파일 검사
				if(file.getContentType().toLowerCase().startsWith("image/")) {
					try {
						String fileName = Utils.getRenamedFileName(file.getOriginalFilename());
						byte[] bytes = file.getBytes();
						String uploadPath = request.getServletContext().getRealPath("/resources/upload/temp");
						File uploadFile = new File(uploadPath);
						if(!uploadFile.exists()) {
							uploadFile.mkdirs();
						}
						//String renamedFilename = Utils.getRenamedFileName(fileName);
						//uploadPath = uploadPath + "/" + fileName;
						out = new FileOutputStream(new File(uploadPath, fileName));
						out.write(bytes);
						
						printWriter = response.getWriter();
						response.setContentType("text/html");
						String fileUrl = request.getContextPath() + "/resources/upload/temp/" + fileName;
						
						//json 데이터로 등록
						json.addProperty("uploaded", 1);
						json.addProperty("fileName", fileName);
						json.addProperty("url", fileUrl);
						
						printWriter.println(json);
						
					} catch(IOException e) {
						e.printStackTrace();
					} finally {
						if(out != null)
							out.close();
						if(printWriter != null)
							printWriter.close();
					}
				}
			}
		}
		//파일이 넘어오지 않았을 경우
		return null;
	}
  ```  
  상품 등록 완료 시, temp폴더의 파일들을 저장소 폴더로 옮기게 되고, 취소 혹은 뒤로가기 선택시 temp폴더 내의 파일들을 삭제하도록 설정되어있다.  
  (ErpController의 productEnroll메소드에 작성되어있는 해당 부분)
  ```java
  //product입력 시, file입력 처리 -> DB에 image등록과 동시에 fileDir옮기기  
  if(result > 0) {
	//folder1의 파일 -> folder2로 복사
	FileUtils.fileCopy(folder1, folder2);
	//folder1의 파일 삭제
	FileUtils.fileDelete(folder1.toString());
	redirectAttr.addFlashAttribute("msg", "상품 추가 완료");
  }else {
	//folder1의 파일 삭제
	FileUtils.fileDelete(folder1.toString());
	redirectAttr.addFlashAttribute("msg", "상품 추가 실패");
  }
  ```
  
-----------------------
### 이 외 구현기능
  
+ 쇼핑몰 일반회원 가입 및 정보 관리 ( 카카오, 네이버 회원 연동 가능 )
+ 상품 결제 시 카카오 페이를 활용한 결제
+ 상품 검색 시 요청 키워드 필터링
+ 오프라인 지점 위치 보기
+ 고객 센터 
+ ERP 게시판 ( 글작성, 상품 요청 - 지점간 요청 및 처리 가능 )
+ ERP 현황 보기 ( admin 고유 기능 - chat.js ) 등


