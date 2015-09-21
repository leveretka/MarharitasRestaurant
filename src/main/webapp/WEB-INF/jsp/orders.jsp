<%--
  Created by IntelliJ IDEA.
  User: margarita
  Date: 03.09.15
  Time: 13:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title></title>
    <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

    <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
    <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
    <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<h1>ALL ORDERS</h1>
<br>

<c:forEach var="order" items="${orders}">

<table border="2">
    <thead>
        <th>ID</th>
        <th>FIRST NAME</th>
        <th>LAST NAME</th>
        <th>LOGIN</th>
        <th>TELEPHONE</th>
        <th>E-MAIL</th>
        <th>ADDRESS</th>
        <th>DATE</th>
        <th>TOTAL COST</th>
        <th>STATUS</th>
    </thead>

    <tr>
        <td>${order.id}</td>
        <td>${order.customer.firstName}</td>
        <td>${order.customer.lastName}</td>
        <td>${order.customer.user.name}</td>
        <td>${order.contact.tel}</td>
        <td>${order.contact.email}</td>
        <td>${order.address}</td>
        <td>${order.date}</td>
        <td>${order.price}</td>
        <td>${order.status}</td>
        <td>
            <c:if test="${order.status == 'NEW'}">
                <form action="/restaurant/jsp/admin/order/acceptorder" method="post">
                    <input type="hidden" name="orderid" value="${order.id}">
                    <input type="submit" value="accept">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                </form>
                <form action="/restaurant/jsp/admin/order/declineorder" method="post">
                    <input type="hidden" name="orderid" value="${order.id}">
                    <input type="submit" value="decline">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                </form>
            </c:if>

            <c:if test="${order.status == 'ACCEPTED'}">
                <form action="/restaurant/jsp/admin/order/deliverorder" method="post">
                    <input type="hidden" name="orderid" value="${order.id}">
                    <input type="submit" value="deliver">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                </form>
            </c:if>

        </td>
        <table border="1">
            <thead><tr>
                <th>MEAL</th>
                <th>TYPE</th>
                <th>OUT</th>
                <th>MEASURE</th>
                <th>PRICE</th>
                <th>QUANTITY</th>
            </tr></thead>

            <c:forEach var="entry" items="${order.meals}">
                <tr>
                    <td>${entry.key.name}</td>
                    <td>${entry.key.mealType}</td>
                    <td>${entry.key.out}</td>
                    <td>${entry.key.measureType}</td>
                    <td>${entry.key.price}</td>
                    <td>${entry.value}</td>
                </tr>

             </c:forEach>
        </table>
    </table>
    <br>
</c:forEach>
</body>
</html>