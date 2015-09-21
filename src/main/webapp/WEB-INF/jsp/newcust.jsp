<%--
  Created by IntelliJ IDEA.
  User: margarita
  Date: 02.09.15
  Time: 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>

<%--<jsp:useBean id="type" type="MealType" />--%>
<%--<jsp:useBean id="measureType" type="MeasureType" />--%>

<html>
<head>
  <title>Customer</title>
  <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

  <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
  <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
  <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<h1>Customer id : ${customer.id}</h1>

<form action="/restaurant/jsp/admin/cust/addcust/" method="post">

  <input type="hidden" name="id" value="${customer.id}"/>

  FIRST NAME : <input type="text" name="firstName" value="${customer.firstName}"/>
  <br>
  LAST NAME : <input type="text" name="lastName" value="${customer.lastName}"/>
  <br>
  LOGIN : <input type="text" name="name" value="${customer.user.name}"/>
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
  ACCUMULATED SUM : <input type="text" name="sum" value="${customer.accumulativeCard.sum}"/>
  <br>

  <input type="hidden" name="pass" value="${customer.user.pass}">
  <input type="hidden" name="enabled" value="${customer.user.enabled}">
  <input type="submit" value="save"/>
  <input type="hidden"
         name="${_csrf.parameterName}"
         value="${_csrf.token}"/>
</form>

</body>
</html>
