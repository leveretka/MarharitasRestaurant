<%--
  Created by IntelliJ IDEA.
  User: margarita
  Date: 01.09.15
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Cabinet</title>
    <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

    <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
    <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
    <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<div id="carte">
<div id="main">
    <h2>My Orders</h2>
    <br>

    <c:forEach var="order" items="${orders}">

        <table border="2">
            <thead>
            <th>TELEPHONE</th>
            <th>E-MAIL</th>
            <th>ADDRESS</th>
            <th>DATE</th>
            <th>TOTAL COST</th>
            <th>STATUS</th>
            </thead>

            <tr>
                <td>${order.contact.tel}</td>
                <td>${order.contact.email}</td>
                <td>${order.address}</td>
                <td>${order.date}</td>
                <td>${order.price}</td>
                <td>${order.status}</td>
                <td>
                    <c:if test="${order.status == 'NEW' or order.status == 'ACCEPTED'}">
                        <form action="/restaurant/jsp/order/cancelorder" method="post">
                            <input type="hidden" name="orderid" value="${order.id}">
                            <input type="submit" value="cancel">
                            <input type="hidden"
                                   name="${_csrf.parameterName}"
                                   value="${_csrf.token}"/>
                        </form>
                    </c:if>

                    <c:if test="${order.status == 'DECLINED' or order.status == 'CANCELLED'}">
                        <form action="/restaurant/jsp/order/resendorder" method="post">
                            <input type="hidden" name="orderid" value="${order.id}">
                            <input type="submit" value="resend">
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
</div>

    <div id="space"></div>

<div id="personal">
    <h2>Personal Info</h2>
    <form action="/restaurant/jsp/cust/addnew/" method="post">

        <input type="hidden" name="id" value="${customer.id}"/>

        FIRST NAME : <input type="text" name="firstName" value="${customer.firstName}"/>
        <br>
        LAST NAME : <input type="text" name="lastName" value="${customer.lastName}"/>
        <br>
        LOGIN : <input type="text" name="name" value="${customer.user.name}"/>
        <br>
        PASSWORD : <input type="password" name="pass" value="${customer.user.pass}"/>
        <br>
        PHONE : <input type="text" name="tel" value="${customer.contact.tel}"/>
        <br>
        E-MAIL : <input type="text" name="email" value="${customer.contact.email}"/>
        <br>
        AREA : <input type="text" name="area" value="${customer.address.area}"/>
        <br>
        DISTRICT : <input type="text" name="district" value="${customer.address.district}"/>
        <br>
        CITY : <input type="text" name="city" value="${customer.address.city}"/>
        <br>
        STREET : <input type="text" name="street" value="${customer.address.street}"/>
        <br>
        BUILDING : <input type="text" name="building" value="${customer.address.building}"/>
        <br>
        APARTMENT : <input type="text" name="apartment" value="${customer.address.apartment}"/>
        <br>
        ACCUMULATED SUM : ${customer.accumulativeCard.sum}
        <br>

        <input type="hidden" name="sum" value="0"/>

        <input type="hidden" name="enabled" value="TRUE">
        <input type="submit" value="save"/>
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}"/>
    </form>


</div>

<c:url var="logoutUrl" value="/logout"/>
<form method="post" action="${logoutUrl}">
  <input type="submit" value="Log out" />
  <input type="hidden"
         name="${_csrf.parameterName}"
         value="${_csrf.token}"/>
</form>
</div>
</body>
</html>
