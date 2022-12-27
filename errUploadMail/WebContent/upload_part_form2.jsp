<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>Part를 이용한 다중 파일 업로드 폼</h2>
<form action="uploadPartProc2" method="post" enctype="multipart/form-data">
업로더 : <input type="text" name="name" /><br />
파일 1: <input type="file" name="file1" /><br />
파일 2: <input type="file" name="file2" /><br />
<input type="submit" value="다중 파일 업로드" />
</form>
</body>
</html>