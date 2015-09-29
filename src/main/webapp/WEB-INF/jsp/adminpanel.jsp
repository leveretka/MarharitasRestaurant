<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: margarita
  Date: 03.09.15
  Time: 13:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><spring:message code="Administrator's MENU"/></title>
    <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

    <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Marck+Script&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
    <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
    <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<div class="menu">
<h1><spring:message code="Administrator's MENU"/></h1>

    <div id="langs">
    <a href="?locale=en">en</a>
    <a href="?locale=uk">uk</a>
    <c:set var="loc" value="${pageContext.response.locale}"/>
        </div>
<br>

    <a href="meals"><spring:message code="MEALS"/></a>
    <a href="customers"><spring:message code="CUSTOMERS"/></a>
    <a href="orders"><spring:message code="ORDERS"/></a>
</div>
</body>

</html>
