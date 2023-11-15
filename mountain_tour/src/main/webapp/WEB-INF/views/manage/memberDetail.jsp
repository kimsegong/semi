<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />


<jsp:include page="../layout/header.jsp">
  <jsp:param value="회원관리" name="title"/>
</jsp:include>

<script src="${contextPath}/resources/js/member_modify.js?dt=${dt}"></script>

<style>
  h3 {
    margin-bottom: 20px;
    text-align: center;
  }

  
</style>

 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid;" >
      
      

      
      <div>
      
        <form id="frm_memberDetail" method="post">
        
        <h3>${user.userNo}번 회원 상세</h3>
        
        
        <div class="mb-3 row">
          <label for="email" class="col-sm-2 col-form-label">이메일</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" id="email" value="${user.email}">
          </div>
        </div>
        <div class="mb-3 row">
          <label for="joined_at" class="col-sm-2 col-form-label">가입일</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" id="joined_at" value="${user.joinedAt}" >
          </div>
        </div>
        
        <div>
        
        <div class="mb-3 row"  >
          <label for="pw_modified_at" class="col-sm-2 col-form-label ">비밀번호 수정일</label>
          <div class="col-sm-10">
            <input type="text" readonly class="form-control-plaintext" id="pw_modified_at" value="${user.pwModifiedAt}" >
          </div>
  
            <div style="text-align: right" >
              <button type="button" id="btn_modify_pw" class="btn btn-sm btn-outline-secondary">비밀번호변경</button>
            </div>
        
        </div>
          </div>
        
        <div class="mb-3 row">
          <label for="name" class="col-sm-2 col-form-label">이름</label>
          <div class="col-sm-5">
            <input type="text" name="name" id="name" value="${user.name}" class="form-control">
            <div id="msg_name"></div>
          </div>
        </div>
        
        
        <div class="mb-3 row" >
          <label for="mobile" class="col-sm-2 col-form-label">휴대전화번호</label>
          <div class="col-sm-5">
            <input type="text" name="mobile" id="mobile" value="${user.mobile}" class="form-control">
            <div id="msg_mobile"></div>
          </div>
        </div>
        
        <div style="text-align: left; margin-left: 17%;">
          <input type="radio" name="gender" value="NO" id="none" class="btn-check">
          <label  class="btn btn-outline-dark" for="none">선택안함</label>
          <input type="radio" name="gender" value="M" id="man" class="btn-check">
          <label  class="btn btn-outline-dark" for="man">남자</label>
          <input type="radio" name="gender" value="F" id="woman" class="btn-check">
          <label  class="btn btn-outline-dark" for="woman">여자</label>
        </div>
        <script>
        	$(':radio[value=${user.gender}]').prop('checked', true);
        </script>
        
        
        <div class="container" style="margin-top: 5%;">
          <div class="row">
            <div class="col-md-6">
              <div class="form-group mb-2">
                <input type="text" id="postcode" placeholder="우편번호" onclick="execDaumPostcode()" readonly value="${user.postcode}" class="form-control">
              </div>
            </div>
            <div class="col-md-6">
              <label>&nbsp;</label>
              <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="btn btn-sm btn-outline-secondary">
            </div>
          </div>
        
          <div class="row">
            <div class="col-md-12">
              <div class="form-group mb-2">
                <input type="text" id="roadAddress" onclick="execDaumPostcode()" readonly placeholder="도로명주소" value="${user.roadAddress}" class="form-control">
              </div>
            </div>
          </div>
        
          <div class="row">
            <div class="col-md-6">
              <div class="form-group mb-2">
                <input type="text" id="jibunAddress" onclick="execDaumPostcode()" readonly placeholder="지번주소" value="${user.jibunAddress}" class="form-control">
              </div>
            </div>
            <span id="guide" style="color:#999;display:none"></span>
            <div class="col-md-6">
              <div class="form-group mb-2">
                <input type="text" id="detailAddress" placeholder="상세주소" value="${user.detailAddress}" class="form-control">
              </div>
            </div>
          </div>
        
          <div class="row">
            <div class="col-md-12">
              <div class="form-group mb-2">
                <input type="text" id="extraAddress" placeholder="참고항목" class="form-control">
              </div>
            </div>
          </div>
        </div>
        
        
        
      <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
      <script>
        //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
        function execDaumPostcode() {
          new daum.Postcode({
            oncomplete: function(data) {
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

              // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var roadAddr = data.roadAddress; // 도로명 주소 변수
              var extraRoadAddr = ''; // 참고 항목 변수

              // 법정동명이 있을 경우 추가한다. (법정리는 제외)
              // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
              if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraRoadAddr += data.bname;
              }
              // 건물명이 있고, 공동주택일 경우 추가한다.
              if(data.buildingName !== '' && data.apartment === 'Y'){
               extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
              }
              // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
              if(extraRoadAddr !== ''){
                extraRoadAddr = ' (' + extraRoadAddr + ')';
              }

              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('postcode').value = data.zonecode;
              document.getElementById("roadAddress").value = roadAddr;
              document.getElementById("jibunAddress").value = data.jibunAddress;
              
              // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
              if(roadAddr !== ''){
                document.getElementById("extraAddress").value = extraRoadAddr;
              } else {
                document.getElementById("extraAddress").value = '';
              }

              var guideTextBox = document.getElementById("guide");
              // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
              if(data.autoRoadAddress) {
                var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                guideTextBox.style.display = 'block';
              } else if(data.autoJibunAddress) {
                var expJibunAddr = data.autoJibunAddress;
                guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                guideTextBox.style.display = 'block';
              } else {
                guideTextBox.innerHTML = '';
                guideTextBox.style.display = 'none';
              }
            }
          }).open();
        }
	  </script>
        
        <div style="margin-top: 6%;" >
          <div style="margin-bottom: 10px; font-weight: bold;">이벤트 알림 동의(선택)</div>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="event" id="event_on" value="on">
            <label class="form-check-label" for="event_on">동의함</label>
          </div>
          <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="event" id="event_off" value="off">
            <label class="form-check-label" for="event_off">동의안함</label>
          </div>
        </div>
        <script>
          if('${user.agree}' === '0'){
        	$('#event_off').prop('checked', true);
          } else if('${user.agree}' === '1'){
        	$('#event_on').prop('checked', true);
          }
        </script>
        
        <div style="margin-top: 6%;" >
          <input type="hidden" name="userNo" value="${user.userNo}">
          <button type="button" id="btn_modify" class="btn btn-success">회원정보수정</button>
          <button type="button" id="btn_leave" class="btn btn-outline-danger">회원탈퇴</button>
        </div>
        
        </form>
        
      </div>
      
      <div style="margin-top: 5%;">
        <a href="${contextPath}/manage/memberList.form"><button class="btn btn-outline-success col-6">목록보기</button></a>
      </div>
      
      
      
      
    </div>
    <div class="col-1">
    </div>
  </div>
</div>
  
 
<script>
  
  
  
</script>
 
 
 

<%@ include file="../layout/footer.jsp" %>