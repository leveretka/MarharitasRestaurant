<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Marharita's Restaurant</title>
    <link href="resources/favicon.ico" rel="shortcut icon" />

    <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="resources/css/template.css" media="screen" />
    <link rel="stylesheet" href="resources/css/colorbox.css" />
    <link rel="stylesheet" href="resources/css/options.css" />

</head>
<body>
<h1>Hello dear guest! Welcome to our restaurant!</h1>
<h2>Locale : ${pageContext.request.locale}</h2>
<a href="/restaurant/jsp/cust/register"><spring:message code="reg"/></a>
<a href="/restaurant/login"><spring:message code="log"/></a>
<a href="/restaurant/jsp/meal/"><spring:message code="menu"/></a>
</body>
</html>