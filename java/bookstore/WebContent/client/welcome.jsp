<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>主页</title>
    <style type="text/css">
    	#content{
    		width:80%;
    	}
    	#categorys{
    		text-align:left;
    		width:200px;
    		border:1px solid #ff0000;
    		height:200px;
    		float:left;
    	}
    	#books{
    		text-align:left;
    		padding-left:50px;
    		float:left; 
    		  		
    	}
    	#image{
    		float:left;  
    	}
    </style>
  </head>
  <body>
  <center>
    <div id="content">
    	
    	<div id="categorys">
    		书籍分类：
    		<ul>
    		<c:forEach var="category" items="${categorys}">
    			<li><a href="${pageContext.request.contextPath }/client/WelcomeServlet?category_id=${category.id }">${category.name }</a></li>
    		</c:forEach>
    		</ul>
    	</div>
    	
    	<div id="books" >
    		<c:forEach var="book" items="${page.list}">
    			<div id="book">
    				<div id="image">
    					<img alt="图书图片" width="50" height="50" src="${pageContext.request.contextPath }/images/${book.images}">
    				</div>
    				<div  style="float:left;">
	    				<ul>
	    					<li>${book.name }</li>
	    					<li>${book.author }</li>
	    					<li>${book.price }</li>
	    					<li><a href="${pageContext.request.contextPath }/client/BuyServlet?operation=buy&bookid=${book.id }">购买</a></li>
	    				</ul>
    				</div>
    				<div style="clear:both"></div><!-- div float之后，一定要清除浮动效果，不然会影响后面页面的显示 -->
    				<br/><br/>
    			</div>
    		</c:forEach>
    	</div>
    	<div style="clear: both"></div>
    	<div id="listpagenum">
 		共有${page.totalrecord}条记录&nbsp;&nbsp;${page.pageNum}/${page.totalpage }
 		<a href="${pageContext.request.contextPath }/client/WelcomeServlet?&category_id=${current_category_id }&pageNum=${page.pageNum-1>0? page.pageNum-1:1}">上一页</a>
		<c:if test="${page.startpage!=1 }">
			<a href="${pageContext.request.contextPath }/client/WelcomeServlet?&category_id=${current_category_id }&pageNum=1">1</a>...			
		</c:if>
	
		<c:forEach begin="${page.startpage }" end="${page.endpage }" var="pageNum">		
			[<a href="${pageContext.request.contextPath }/client/WelcomeServlet?pageNum=${pageNum }&category_id=${current_category_id }">${pageNum }</a>]
		</c:forEach>
		<c:if test="${page.endpage!=page.totalpage}">
			...<a href="${pageContext.request.contextPath }/client/WelcomeServlet?pageNum=${pageNum }&category_id=${current_category_id }">${page.totalpage }</a>
		</c:if>
		<a href="${pageContext.request.contextPath }/client/WelcomeServlet?pageNum=${page.pageNum+1>=page.totalpage? page.totalpage:page.pageNum+1}&category_id=${current_category_id }">下一页</a>		
	    	</div>
	    </div>
    </center>
  </body>
</html>
