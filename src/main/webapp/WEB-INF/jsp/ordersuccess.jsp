<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: margarita
  Date: 06.09.15
  Time: 22:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Order success</title>
  <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

  <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Marck+Script&subset=latin,cyrillic' rel='stylesheet' type='text/css'>

  <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
  <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
  <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>

<div class="wrapper">
<h2><spring:message code="order_success"/></h2>
<c:set var="loc" value="${pageContext.response.locale}"/>
  <a href="/restaurant/jsp/meal/"><spring:message code="menu"/></a>
</div>

</body>
</html>
