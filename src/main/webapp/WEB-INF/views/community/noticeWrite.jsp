<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<fmt:requestEncoding value="utf-8"/>
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="CodeLit" name="title"/>
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/community.css">

<script>
window.onload = function() {
  let upFile = document.getElementById('upFile');
  let thumb = document.getElementById('photo_img');
  upFile.addEventListener('change', function(e) {
    
    if(upFile.files[0] != null) {
      thumb.src = URL.createObjectURL(upFile.files[0]);
    } else {
      thumb.src = "";
    }

  });
}
// 유효성검사
function checkContent() {
	const $title = $("#msgTitle");
	const $content = $("#msgContent");
	if(/^(.|\n)+$/.test($title.val()) == false){
		alert("제목을 입력하세요");
		return false;
	}
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	sendMessage("/app/user");
	return true;
}
</script>
  	<div class="container content-container">
        <div class="row mt-5">
          <h2 class=" jb-larger mt-3 col-sm-5"><spring:message code="menu.notice"/></h2>
        </div>
        
        <form action="${pageContext.request.contextPath}/community/noticeInsert.do?${_csrf.parameterName}=${_csrf.token}"
  			enctype="multipart/form-data" 
        	method="post" 
        	onsubmit="return checkContent();">
          <div class="row title-group">
            <h5 class="col-sm-2 board-title"><spring:message code="user.boardTitle"/></h5>
            <div class="col-sm-10">
              <input class="form-control" type="text" name="noticeTitle" id="msgTitle">
            </div>
          </div>
          <div class="board-container">
            <!-- 이미지가 들어가면 콘텐츠에서 보여줘야함. 어떻게 서버처리할지 생각해볼것. -->
            <div class="form-group content">
              <textarea class="form-control" name="noticeContent" id="msgContent" rows="10"></textarea>
              	<div class="custom-file">
	              	<img src="" alt="" id="photo_img">
	                <input type="file" class="custom-file-input" name="upFile" id="upFile" accept="image/jpeg, image/jpg, image/png">
              	</div>
            </div>
          </div>
          <div class="boardList-footer mt-2">
            <!-- 관리자-->
            <button type="reset" class="btn btn-danger cancel-btn" onclick="location.href='${pageContext.request.contextPath}/community/noticeList.do'"><spring:message code="admin.backBtn"/></button>
            <button type="submit" id="sendBtn" class="btn btn-primary complete-btn"><spring:message code="help.writeBtn"/></button>
          </div>
        </form>
      </div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>