<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
    <title>Administration Panel</title>
    <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

    <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
    <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
    <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<h1><fmt:message key="Administrator's MENU" bundle="${lang}"/></h1>

  <form action="admintype" method="post">
    <button type="submit" name="type" value="MEALS">MEALS</button>
    <button type="submit" name="type" value="CUSTOMERS">CUSTOMERS</button>
    <button type="submit" name="type" value="ORDERS">ORDERS</button>
    <input type="hidden"
           name="${_csrf.parameterName}"
           value="${_csrf.token}"/>
  </form>


<c:url var="logoutUrl" value="/logout"/>
<form method="post" action="${logoutUrl}">
    <input type="submit" value="Log out" />
    <input type="hidden"
           name="${_csrf.parameterName}"
           value="${_csrf.token}"/>
</form>

</body>
</html>
