<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>파일 업로드 폼(cos.jar 이용)</h2>
<form action="upload_cos_proc.jsp" method="post" enctype="multipart/form-data">
업로더 : <input type="text" name="name" /><br />
제목 : <input type="text" name="title" /><br />
파일1 : <input type="file" name="file1" /><br />
파일2 : <input type="file" name="file2" /><br />
<input type="submit" value="파일 업로드" />
</form>
</body>
</html>
