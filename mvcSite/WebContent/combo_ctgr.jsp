<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="_inc/inc_head.jsp" %>
<%
request.setCharacterEncoding("utf-8");
ArrayList<ProductCtgrBig> bigList = 
	(ArrayList<ProductCtgrBig>)request.getAttribute("bigList");
ArrayList<ProductCtgrSmall> smallList = 
	(ArrayList<ProductCtgrSmall>)request.getAttribute("smallList");
%>

<script>
<% 
for (int i = 0; i < bigList.size(); i++) { 
	String arr= "arr" + bigList.get(i).getPcb_id();
%>
	var <%=arr %> = new Array();
	<%=arr %>[0] = new Option("", " 소분류 선택");
<% 
	for (int j = 0, k = 1; j < smallList.size(); j++, k++) {
		ProductCtgrSmall pcs = smallList.get(j);
		if (pcs.getPcb_id().equals(bigList.get(i).getPcb_id())){
%>
	<%=arr %>[<%=k %>] = 
		new Option("<%=pcs.getPcs_id() %>", "<%=pcs.getPcs_name() %> ");
<%
		} else {
			k = 0;
		}
	}
}
%>
	var arr1 = new Array();	// 첫번째 대분류(대분류값 1)에 속한 소분류 메뉴(option 태그)를 저장할 배열
	arr1[0] = new Option("", " 소분류 선택 ");
	arr1[1] = new Option("1", " 농구화 ");	arr1[2] = new Option("2", " 축구화 ");
	arr1[3] = new Option("3", " 러닝화 ");	arr1[4] = new Option("4", " 야구화 ");

	var arr2 = new Array();	// 두번째 대분류(대분류값 2)에 속한 소분류 메뉴(option 태그)를 저장할 배열
	arr2[0] = new Option("", " 소분류 선택 ");
	arr2[1] = new Option("1", " 로퍼 ");		arr2[2] = new Option("2", " 플레인 토 ");
	arr2[3] = new Option("3", " 윙팀 ");		arr2[4] = new Option("4", " 더비 ");

	function setCategory(x, target) {
	// x : 대분류에서 선택한 값 / target : 선택한 대분류에 따라 보여줄 소분류 콤보박스 객체
	
		// 1. 원래 소분류 콤보박스에 있던 데이터(option 태그)들을 모두 삭제
		for (var i = target.options.length - 1 ; i > 0 ; i--) {
			target.options[i] = null;
		}

		// 2. 선택한 대분류에 속하는 소분류 데이터를 소분류 콤보박스에 넣음
		if (x != "") {	// 특정 대분류를 선택했으면
			var arr = eval("arr" + x);
			// 대분류에서 선택한 값에 따라 사용할 배열을 지정 : 소분류 콤보박스에서 보열줄 option 태그들

			for (var i = 0 ; i < arr.length ; i++) {
				target.options[i] = new Option(arr[i].value, arr[i].text);
				// 지정한 arr배열 만큼 target에 option요소 추가
			}

			target.options[0].selected = true;
			// target의 0번 인덱스에 해당하는 option태그를 선택한 상태로 만듦
		}
	}
	</script>
</head>
<body>
<form name="frm">
<select name="pcb" onchange="setCategory(this.value, this.form.pcs);">
<!-- this.value : 자신이 선택한 값 / this.form.pcs : 자신이 속한 폼안에 있는 pcs라는 컨트롤 객체 -->
	<option value=""> 대분류 선택 </option>
<% 
for (int i = 0; i < bigList.size(); i++) { 
	ProductCtgrBig pcb = bigList.get(i);
%>
	<option value="<%=pcb.getPcb_id() %>"><%=pcb.getPcb_name() %></option>
<% } %>
</select>
<select name="pcs">
	<option value=""> 소분류 선택 </option>
</select>
</form>
</body>
</html>