<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_inc/inc_price.jsp" %>

<style>
.banner {
	width:100%;
	margin:100px 0;
}
.banner > div {
	width:1000px;
	height:500px;
	background-color: red;
	margin:0 auto;
}
.banner img {
	width:100%;
}

.product {
	width:1000px;
	margin:0 auto;
}
.product > div {
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
	border-bottom: 1px solid #000;
}
.product ul {
	display: flex;
	justify-content: space-between;
	align-items: flex-end;
	flex-wrap:wrap;
}
.product li {
	margin: 30px 0;
}
.product h3 {
	font-size: 23px;
	margin:16px 0;
}

.product img {
	width:210px;
	height:270px;
}
.product h2 {
	white-space: pre-line;
	text-align: center;
}
</style>
<script>
$( document ).ready( function() {
    $( '.slider' ).slick( {
      autoplaySpeed: 1000,
      arrows : true,
      pauseOnHover : true,  
    } );
  } );
</script>
<body>
<section class="banner">
<div class="slider">
		<div><img src="/greenPhone/img/event1.png" /></div>
		<div><img src="/greenPhone/img/event2.png" /></div>
		<div><img src="/greenPhone/img/event3.png" /></div>
</div>
</section>
<section class="product">
	<div>
		<h3>최신 상품</h3>
		<p>더보기...</p>
	</div>
	<ul>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
	</ul>
</section>
<section class="product">
	<div>
		<h3>인기 상품</h3>
		<p>더보기...</p>
	</div>
	<ul>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
	</ul>
</section>
<section class="product">
	<div>
		<h3>할인 상품</h3>
		<p>더보기...</p>
	</div>
	<ul>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
		<li>
			<img src="./img/product_img/sam/S23/galaxy_S23/s2301_1.png" />
			<h2>갤럭시 S22
			490,000 ~</h2>
		</li>
	</ul>
</section>


</body>
</html>