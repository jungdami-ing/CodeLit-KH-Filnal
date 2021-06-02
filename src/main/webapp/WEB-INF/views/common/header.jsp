<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<%-- 로그인 검증용 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 다국어  -->
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${param.title}</title>

<!-- jQuery -->
<script src="http://code.jquery.com/jquery-latest.min.js"></script>


<!-- Bootstrap JS : JQuery load 이후에 작성할것.-->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-gtEjrD/SeCtmISkJkNUaaKMoLD0//ElJ19smozuHV6z3Iehds+3Ulb9Bn9Plx0x4"
	crossorigin="anonymous"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">

<!-- Font Awesome(아이콘) CSS -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.3/css/all.css"
	integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk"
	crossorigin="anonymous">

<!-- websocket 관련 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.js" integrity="sha512-Kdp1G1My+u1wTb7ctOrJxdEhEPnrVxBjAg8PXSvzBpmVMfiT+x/8MNua6TH771Ueyr/iAOIMclPHvJYHDpAlfQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.js" integrity="sha512-tL4PIUsPy+Rks1go4kQG8M8/ItpRMvKnbBjQm4d2DQnFwgcBYRRN00QdyQnWSCwNMsoY/MfJY8nHp2CzlNdtZA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />


<!-- 사용자작성 JS -->
<script src="${pageContext.request.contextPath}/resources/js/header.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/alarm.js"></script>

<!-- 사용자작성 CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />

<!-- redirectAttr.addFlashAttribute의 저장된 속성값 사용(1회용) -->
<c:if test="${not empty msg}">
<script>
alert("${msg}");
</script>
</c:if>
</head>
<body>
	<header class="sticky-top">

		<nav class="navbar navbar-expand-lg navbar-dark">
			<div class="container">
				<a class="navbar-brand me-4" href="${pageContext.request.contextPath}">CodeL!t</a>

				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarMain"
					aria-controls="navbarMain" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse col-sm-2" id="navbarMain">
					<ul class="navbar-nav">
						<li class="nav-item dropdown mx-2">
							<a 	class="nav-link dropdown-toggle" href="#"
								id="navlinkDropdownCommunity" role="button"
								data-bs-toggle="dropdown" aria-expanded="false"><spring:message code="menu.communities"/></a>
							<ul class="dropdown-menu" id="dropdownCommunity"
								aria-labelledby="navlinkDropdownCommunity">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/community/noticeList.do"><spring:message code="menu.notice"/></a></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/community/studyList.do"><spring:message code="menu.community"/></a></li>
							</ul>
						</li>
						<li class="nav-item dropdown mx-2">
							<a
								class="nav-link dropdown-toggle" href="#"
								id="navlinkDropdownLecture" role="button"
								data-bs-toggle="dropdown" aria-expanded="false"><spring:message code="menu.lecture"/></a>
							<ul class="dropdown-menu" id="dropdownLecture"
								aria-labelledby="navlinkDropdownLecture">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecture/lectureList.do"><spring:message code="menu.allLecture"/></a></li>
								<c:forEach items="${categoryList}" var="category">
									<li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecture/lectureList.do/${category.no}">${category.name}</a></li>
								</c:forEach>
							</ul>
						</li>
						<sec:authorize access="hasRole('USER') && !hasRole('ADMIN')">
						<li class="nav-item mx-2"><a class="nav-link" href="${pageContext.request.contextPath}/counsel/counselList.do"><spring:message code="menu.help"/></a></li>
						</sec:authorize>


						<sec:authorize access="hasRole('ADMIN')">
						<li class="nav-item mx-2"><a class="nav-link" href="${pageContext.request.contextPath}/counsel/counselListAdmin.do"><spring:message code="menu.help"/></a></li>
						</sec:authorize>

					</ul>
				</div>

				<!-- 비로그인 -->
				<sec:authorize access="isAnonymous()">
					<div class="collapse navbar-collapse justify-content-end"
						id="navbarMain">
						<ul class="navbar-nav">
							<li class="nav-item m-1"><a	class="btn btn-warning nav-link text-light"	href="${pageContext.request.contextPath}/member/memberLogin.do"><spring:message code="menu.login"/></a></li>
							<li class="nav-item m-1"><a
								class="btn btn-primary nav-link text-light" href="${pageContext.request.contextPath}/member/memberEnroll.do"><spring:message code="menu.join"/></a>
							</li>
						</ul>
					</div>
				</sec:authorize>

				<!-- 일반 사용자 로그인 -->
				<sec:authorize access="isAuthenticated()">

					<div class="collapse navbar-collapse justify-content-end" id="navbarMain">
						<span class="navbar-text fs-5 text-light">
							<sec:authentication property="principal.username"/>
						</span>
						<span class="navbar-text fs-6 text-light ms-1">님</span>
						<ul class="navbar-nav">
							<li class="nav-item dropdown">
								<a class="nav-link btn btn-warning dropdown-toggle text-dark mx-3 mt-1" href="#" id="dropdownUserMenu" role="button" data-bs-toggle="dropdown" aria-expanded="false">
									메뉴
								</a>
								<ul class="dropdown-menu" aria-labelledby="dropdownUserMenu">
									<form:form action="${pageContext.request.contextPath}/member/memberLogout.do" method="POST">
									<button class="dropdown-item" type="submit">로그아웃</button>
									</form:form>
									<sec:authorize access="hasRole('USER') && !hasRole('ADMIN')">
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/myProfile.do">마이페이지</a></li>
										<!-- <li><a class="dropdown-item" href="#">내 글 보기</a></li> -->
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/member/memberLectureList.do">수강중인 강의</a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/order/pick.do">찜 목록</a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/order/basket.do">장바구니</a></li>
										<!-- <li><a class="dropdown-item" href="#">결제내역</a></li> -->
									</sec:authorize>
									<sec:authorize access="hasRole('USER') && !hasAnyRole('TEACHER', 'ADMIN')">
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/teacher/teacherRequest.do">강사 신청</a></li>
									</sec:authorize>
									<sec:authorize access="hasRole('TEACHER')">
										<hr/>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/teacher/teacherProfile.do">강사페이지</a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/lecture/lectureEnroll.do">강의등록</a></li>
										<%-- <li><a class="dropdown-item" href="${pageContext.request.contextPath}/teacher/lectureCalList.do">정산내역</a></li> --%>
									</sec:authorize>
									<sec:authorize access="hasRole('ADMIN')">
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/applyTeacherList.do">강사 신청 목록</a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/applyLectureList.do">강의 신청 목록</a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/manageLectureBoard.do">강의 관리</a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/admin/manageMemberIndex.do">회원 관리</a></li>
										<li><a class="dropdown-item" href="${pageContext.request.contextPath}/alarm/alarmList.do">알림</a></li>
									</sec:authorize>

				                </ul>
			              	</li>
			             	<li>
			                	&nbsp;&nbsp;&nbsp;
			              	</li>
			              	<li class="nav-item">
			                	<a class="nav-link px-0" href="${pageContext.request.contextPath}/alarm/alarmList.do" id="alertsDropdown" style="font-size: 1.5rem;">
			                    	<c:if test="${readVal > 0}">
				                    	<i class="fas fa-bell my-auto my-bell"></i>
			                    	</c:if>
			                    	<c:if test="${readVal == 0}">
				                    	<i class="far fa-bell my-auto"></i>
			                    	</c:if>
			                    	<!-- 알림 여부에 따라 아이콘 바꾸기 -->
			                    	<span class="badge badge-danger badge-counter"></span>
			                	</a>
			              	</li>
			            </ul>
			         </div>
				</sec:authorize>

			</div>
		</nav>
	</header>

	<section id="content">
	<!-- header.jsp 끝 -->