<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<c:set var="dt" value="<%=System.currentTimeMillis()%>" />

<jsp:include page="../layout/header.jsp">
  <jsp:param value="마운틴투어상품게시글작성" name="title"/>
</jsp:include>
<style>

</style>
 
  <div class="container text-center">
  <div class="row">
    <div class="col-1">      
    </div>
    <div class="col-10" style = "border: 1px gray solid; height: 2500px" >
      <!--  여기다가 작성  다 작성하고 height 지우기!!!! -->
      
	  
	 <div class="row">
    	<div class="col-8" style="margin-top: 30px; margin-bottom: 30px;">
    	  <img alt="" src="https://github.com/skal48/portfolio/blob/main/seolark2.jpg?raw=true" width="500px" height="400px">
    	  <hr>
    	  <div style = "text-align: left;">
    	   <div>
	        <label for="title" class="form-label">제목</label>
	        <input type="text" name="title" id="title" class="form-control">
	       </div>
	      </div>
    	  <div style = "text-align: right;">
    	  <div>
	        <label for="prize" class="form-label">가격</label>
	        <input type="text" name="prize" id="prize" class="form-control">
	      </div>
	      </div>
    	  <div style = "border: 1px gray solid; height: 200px">
    	  
    	  
    	  
    	  
    	  
    	  </div>
    	  <div class="choice">상품선택</div>
    	  <div class="calender">
    	  <div style = "text-align: left; font-size:16px;">출발일 선택</div>
	    	 <div class="calender_mini">
	    	  
	    	 <div id="datepicker"></div>
	    	 
    
			

	    	  
	    	 </div>
    	  <div style = "text-align: left; font-size:16px; border: 1px gray solid; height: 300px">상품 선택</div>
    	  	 <div>
	    	  
	    	  
	    	  
	    	 </div>
    	  </div>
    	  <form method="post" action="${contextPath}/product/add.do" enctype="multipart/form-data">
    	  <div class="choice">주요 여행일정</div>
    	    <div>
    	     <div>
		      <label for="contents" class="form-label"></label>
		      <textarea rows="10" cols="20" name="contents" id="contents" class="form-control"></textarea>
	    	</div>
    	     
    	  
    	  
    	  
    	    </div>
    	    </form>
    	    <form method="post" action="${contextPath}/product/add.do" enctype="multipart/form-data">
    	  <div class="choice">상품정보</div>
    	    <div>
    	  	<div>
		      <label for="contents" class="form-label"></label>
		      <textarea rows="10" cols="20" name="contents" id="contents" class="form-control"></textarea>
	    	</div>
    	    <div>
		      <label for="files" class="form-label"></label>
		      <input type="file" name="files" id="files" class="form-control" multiple>
	        </div>
    	  
    	  
    	  
    	    </div>
    	    </form>
    	  <div class="choice">약관/정보</div>
    	    <div style = "border: 1px gray solid; height: 100px">
    	  
    	  
    	  
    	  
    	  
    	    </div>
    	  
    	</div>   	   
    	<div class="col-4"> <!-- style="border-left: 2px solid gray;" -->
       <div>
	   <div id="side-bar" class="css-17dn726" style="position: sticky; top: 80px;">
	   <div class="css-wldo8h"><div class="css-a5xtki">
	   <div class="css-17dn726">
	   <div class="css-vurnku">
	   <div class="css-7nm51y">선택중인 행사</div>
	   <div class="css-jqbm3n">
	   	<div>
	        <label for="title" class="form-label">제목</label>
	        <input type="text" name="title" id="title" class="form-control">
	       </div>
	    </div>
	   </div>
	   <hr class="css-8hwf4v">
	   <div class="css-mbxvxt">행사금액</div>
	   <div class="css-oxy8lg">
	   <div class="css-1xhmgr4">
	   <div>
	        <label for="prize" class="form-label">가격</label>
	        <input type="text" name="prize" id="prize" class="form-control">
	   </div>
	   </div>
	   </div>
	   <button class="css-8mw6wv">
	   <div class="css-zy66z9">
	   <div class="css-1lvghmf">찜하기</div>
	   <svg width="20" height="19" viewBox="0 0 20 19" fill="none" xmlns="http://www.w3.org/2000/svg" class="css-1vp9y8d">
	   </svg>
	   </div>
	   </button>
	   <button class="css-1axms61">
	   <div class="css-zy66z9">
	   <div class="css-1p9c0kq">다른 출발일 보기</div>
	   </div>
	   </button>
	   </div>
	   </div>
	   </div>
	   <div class="css-r8ib8s">
	   <div class="share-box2 css-15a582q">공유하기</div>
	   <div class="share-box2 css-9o9ge6">
	   <svg class="share-box2 css-2ijsu3" width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
	   </svg>
	   </div>
	   </div>
	   </div>
	  </div>
    	</div>  	
  	  </div>
	  
	  
	  
		       
      
      
      
      
      
      
      

    </div>
	  
	    <div class="d-grid gap-2 col-6 mx-auto">
	      <input type="hidden" name="userNo" value="${sessionScope.user.userNo}">
	      <button type="submit" class="btn btn-primary" style="margin: 32px;">작성완료</button>
	    </div>

	       
      
      
      
      
      
      
      

    </div>
    <div class="col-1">
    </div>
  </div>

  
  <script>
 
  
  
  </script>
 
 
 
 
 

<%@ include file="../layout/footer.jsp" %>