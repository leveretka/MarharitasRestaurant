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
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--<jsp:useBean id="type" type="MealType" />--%>
<%--<jsp:useBean id="measureType" type="MeasureType" />--%>

<html>
<head>
  <title>Customer</title>
  <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

  <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
  <link href='https://fonts.googleapis.com/css?family=Marck+Script&subset=latin,cyrillic' rel='stylesheet' type='text/css'>

  <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
  <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
  <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<div id="carte-1">
  <div id="registration">
<h1><spring:message code="customer"/> id : ${customer.id}</h1>
<c:set var="loc" value="${pageContext.response.locale}"/>

<form action="/restaurant/jsp/admin/cust/addcust/" method="post">

  <input type="hidden" name="id" value="${customer.id}"/>

  <spring:message code="firstName"/> : <input type="text" name="firstName" value="${customer.firstName}"/>
  <br>
  <spring:message code="lastName"/> : <input type="text" name="lastName" value="${customer.lastName}"/>
  <br>
  <spring:message code="LOGIN"/> : <input type="text" name="name" value="${customer.user.name}"/>
  <br>
  <spring:message code="PASS"/> : <input type="password" name="pass" value="${customer.user.pass}"/>
  <br>
  <spring:message code="phone"/> : <input type="text" name="tel" value="${customer.contact.tel}"/>
  <br>
  <spring:message code="e-mail"/> : <input type="text" name="email" value="${customer.contact.email}"/>
  <br>
  <spring:message code="area"/> : <input type="text" name="area" value="${customer.address.area}"/>
  <br>
  <spring:message code="district"/> : <input type="text" name="district" value="${customer.address.district}"/>
  <br>
  <spring:message code="city"/> : <input type="text" name="city" value="${customer.address.city}"/>
  <br>
  <spring:message code="street"/> : <input type="text" name="street" value="${customer.address.street}"/>
  <br>
  <spring:message code="building"/> : <input type="text" name="building" value="${customer.address.building}"/>
  <br>
  <spring:message code="apartment"/> : <input type="text" name="apartment" value="${customer.address.apartment}"/>
  <br>
  <spring:message code="accumulated_sum"/> : <input type="text" name="sum" value="${customer.accumulativeCard.sum}"/>
  <br>

  <spring:message code="save" var="save"/>
  <input type="hidden" name="pass" value="${customer.user.pass}">
  <input type="hidden" name="enabled" value="${customer.user.enabled}">
  <input type="submit" value="${save}"/>
  <input type="hidden"
         name="${_csrf.parameterName}"
         value="${_csrf.token}"/>
</form>
  </div>
  <c:if test="${errors != null}">
    <div id="error-panel">
      <ul>
        <c:forEach var="error" items="${errors}">
          <li><spring:message code="${error}"/></li>
        </c:forEach>
      </ul>
    </div>
  </c:if>
</div>
</body>
</html>
