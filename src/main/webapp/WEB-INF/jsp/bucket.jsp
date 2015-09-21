<%--
  Created by IntelliJ IDEA.
  User: margarita
  Date: 01.09.15
  Time: 15:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<html>
<head>
    <title>Bucket</title>
  <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

  <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
  <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
  <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<h1>YOUR BUCKET</h1>
<table border="1">
  <thead>
  <th>NAME</th>
  <th>PRICE</th>
  <th>OUT</th>
  <th>MEASURE</th>
  <th>quantity</th>
  <th> - </th>
  </thead>
  <c:forEach var="meal" items="${order.meals}">
    <tr>
      <td>${meal.key.name}</td>
      <td>${meal.key.price}</td>
      <td>${meal.key.out}</td>
      <td>${meal.key.measureType}</td>
      <td>${meal.value}</td>
      <td>

        <form action="/restaurant/jsp/order/removemeal" method="post">
          <input type="hidden" name="mealid" value="${meal.key.id}" />
          <input type="submit" name ="send" value="minus" />
          <input type="hidden"
                 name="${_csrf.parameterName}"
                 value="${_csrf.token}"/>
        </form>
      </td>
    </tr>
  </c:forEach>
</table>

<p>
  Total cost : ${order.price}
</p>
<form action="/restaurant/jsp/order/submitorder" method="post">
PHONE : <input type="text" name="tel" value="${order.customer.contact.tel}"/>
<br>
E-MAIL : <input type="text" name="email" value="${order.customer.contact.email}"/>
<br>
AREA : <input type="text" name="area" value="${order.customer.address.area}"/>
<br>
DISTRICT : <input type="text" name="district" value="${order.customer.address.district}"/>
<br>
CITY : <input type="text" name="city" value="${order.customer.address.city}"/>
<br>
STREET : <input type="text" name="street" value="${order.customer.address.street}"/>
<br>
BUILDING : <input type="text" name="building" value="${order.customer.address.building}"/>
<br>
APARTMENT : <input type="text" name="apartment" value="${order.customer.address.apartment}"/>
<br>
  <input type="submit" value="Send">
  <input type="hidden"
         name="${_csrf.parameterName}"
         value="${_csrf.token}"/>
</form>

<a href="/restaurant/jsp/meal/">Back to menu</a>

<sec:authorize access="isFullyAuthenticated()">

<c:url var="logoutUrl" value="/logout"/>
<form method="post" action="${logoutUrl}">
  <input type="submit" value="Log out" />
  <input type="hidden"
         name="${_csrf.parameterName}"
         value="${_csrf.token}"/>

</form>
</sec:authorize>
</body>
</html>
