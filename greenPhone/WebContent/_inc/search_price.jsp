<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="/mvcSite/js/jquery-3.6.1.js"></script>

<style>
.submenu {
  list-style-type: none;
  position: right;
  display: none; <!--로드했을 때 submenu가 안보이게 하기 위함 -->
}
</style>
<script>
$("li").click(function () {
    if ($(this).hasClass("active")) {
      $(this).children().css("display", "none");
      $(this).removeClass();
    } else {
      $(this).addClass("active");
      $(this).children().css("display", "block");
    }
  });
</script>
</head>
<body>
<div>
              <ul id="menu">
                <li>
                  menu1
                  <ul class="submenu">
                    <li><a href="">submenu1</a></li>
                    <li><a href="">submenu2</a></li>
                    <li><a href="">submenu3</a></li>
                  </ul>
                </li>
                <li>
                  menu2
                  <ul class="submenu">
                    <li><a href="">submenu1</a></li>
                    <li><a href="">submenu2</a></li>
                    <li><a href="">submenu3</a></li>
                  </ul>
                </li>
                <li>
                  menu3
                  <ul class="submenu">
                    <li><a href="">submenu1</a></li>
                    <li><a href="">submenu2</a></li>
                    <li><a href="">submenu3</a></li>
                  </ul>
                </li>
              </ul>
            </div>
</body>
</html>