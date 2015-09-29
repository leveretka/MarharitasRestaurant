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
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="bucket"/></title>
  <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

  <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Marck+Script&subset=latin,cyrillic' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
  <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
  <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<c:set var="loc" value="${pageContext.response.locale}"/>
<div id="bucket">
<div id="header">
  <h1><spring:message code="your_order"/></h1>
    <c:if test="${errors == null}">
        <a href="?locale=en">en</a>
        <a href="?locale=uk">uk</a>
    </c:if>
</div>
<div id="order_items">
<table border="1">
  <thead>
  <th><spring:message code="name"/></th>
  <th><spring:message code="price"/></th>
  <th><spring:message code="out"/></th>
  <th><spring:message code="measureType"/></th>
  <th><spring:message code="qnt"/></th>
  <th> -/+ </th>
  </thead>
  <c:forEach var="meal" items="${order.meals}">
    <tr>
      <td>${meal.key.getName(loc)}</td>
      <td>${meal.key.price}</td>
      <td>${meal.key.out}</td>
      <td><spring:message code="${meal.key.measureType}"/></td>
      <td>${meal.value}</td>
      <td>
        <form action="/restaurant/jsp/order/removemeal" method="post">
          <input type="hidden" name="mealid" value="${meal.key.id}" />
          <input type="submit" name ="send" value=" - " />
          <input type="hidden"
                 name="${_csrf.parameterName}"
                 value="${_csrf.token}"/>
        </form>
        <form action="/restaurant/jsp/order/addmeal" method="post">
          <input type="hidden" name="mealid" value="${meal.key.id}" />
          <input type="hidden" name="redirect" value="order/previewOrder">
          <input type="submit" name ="send" value=" + " />
          <input type="hidden"
                 name="${_csrf.parameterName}"
                 value="${_csrf.token}"/>
        </form>
      </td>
    </tr>
  </c:forEach>
</table>

<p>
  <spring:message code="totalCost"/> : ${order.price}
</p>
  </div>
<div id="order_info">
  <h2><spring:message code="additionalInfo"/></h2>
<form action="/restaurant/jsp/order/submitorder" method="post">
  <spring:message code="phone"/> : <input type="text" name="tel" value="${order.customer.contact.tel}"/>
<br>
    <spring:message code="e-mail"/> : <input type="text" name="email" value="${order.customer.contact.email}"/>
<br>
      <spring:message code="area"/> : <input type="text" name="area" value="${order.customer.address.area}"/>
<br>
        <spring:message code="district"/> : <input type="text" name="district" value="${order.customer.address.district}"/>
<br>
          <spring:message code="city"/> : <input type="text" name="city" value="${order.customer.address.city}"/>
<br>
            <spring:message code="street"/> : <input type="text" name="street" value="${order.customer.address.street}"/>
<br>
              <spring:message code="building"/> : <input type="text" name="building" value="${order.customer.address.building}"/>
<br>
                <spring:message code="apartment"/> : <input type="text" name="apartment" value="${order.customer.address.apartment}"/>
<br>
    <c:if test="${errors != null}">
        <div id="errors">
            <ul>
                <c:forEach var="error" items="${errors}">
                    <li><spring:message code="${error}"/></li>
                </c:forEach>
            </ul>
        </div>
    </c:if>

    <spring:message code="send" var="send"/>
  <input type="submit" value="${send}">
  <input type="hidden"
         name="${_csrf.parameterName}"
         value="${_csrf.token}"/>
</form>
</div>
<a href="/restaurant/jsp/meal/"><spring:message code="show_menu"/></a>

<sec:authorize access="isFullyAuthenticated()">

<c:url var="logoutUrl" value="/logout"/>
  <spring:message code="log_out" var="logout"/>
<form method="post" action="${logoutUrl}">
  <input type="submit" value="${logout}" />
  <input type="hidden"
         name="${_csrf.parameterName}"
         value="${_csrf.token}"/>
</form>
</sec:authorize>
  </div>
</body>
</html>
