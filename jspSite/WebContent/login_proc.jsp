<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>
<%
if (login_info != null){	// 이미 로그인이 되어 있다면
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.'); history.back();");
	out.println("</script>");
	out.close();
}

request.setCharacterEncoding("utf-8");
String uid = request.getParameter("uid").trim().toLowerCase();
String pwd = request.getParameter("pwd").trim();

if (uid == null || uid.equals("") || pwd == null || pwd.equals("")){
	out.println("<script>");
	out.println("alert('아이디와 비밀번호를 입력하세요.'); history.back();");
	out.println("</script>");
	out.close();
}

try {
	stmt = conn.createStatement();
	sql = "select * from t_member_info where mi_status <> 'c' and mi_id = '" + uid + "' and mi_pw = '" + pwd + "'";
	// System.out.println(sql);
	rs = stmt.executeQuery(sql);
	
	if (rs.next()){	// 로그인 성공시
		MemberInfo mi = new MemberInfo();
		// 로그인한 회원의 정보들을 저장할 인스턴스 생성
		mi.setMi_id(uid);
		mi.setMi_pw(pwd);
		mi.setMi_id(rs.getString("mi_id"));
		mi.setMi_pw(rs.getString("mi_pw"));
		mi.setMi_name(rs.getString("mi_name"));
		mi.setMi_gender(rs.getString("mi_gender"));
		mi.setMi_birth(rs.getString("mi_birth"));
		mi.setMi_phone(rs.getString("mi_phone"));
		mi.setMi_email(rs.getString("mi_email"));
		mi.setMi_point(rs.getInt("mi_point"));
		mi.setMi_lastlogin(rs.getString("mi_lastlogin"));
		mi.setMi_joindate(rs.getString("mi_joindate"));
		mi.setMi_status(rs.getString("mi_status"));
		
		session.setAttribute("login_info", mi);
		// 로그인한 회원 정보를 담은 MemberInfo형 인스턴스 mi를
		// 세션에 'login_info'라는 이름의 속성으로 저장
		
		response.sendRedirect("index.jsp");
		
	} else {			// 로그인 실패시
		out.println("<script>");
		out.println("alert('아이디와 비밀번호를 확인 후 다시 로그인 하세요.');");
		out.println("history.back();");
		out.println("</script>");
	}
	
} catch (Exception e) {
	out.println("로그인 처리시 문제가 발생했습니다.");
	e.printStackTrace();
} finally {
	try {
		rs.close();		stmt.close();
	} catch (Exception e){
		e.printStackTrace();
	}
}
%>
<%@ include file="_inc/inc_foot.jsp" %>