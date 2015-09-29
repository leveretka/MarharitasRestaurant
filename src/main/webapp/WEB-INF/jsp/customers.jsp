<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>JSP Page</title>
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
  <h1><spring:message code="CUSTOMERS"/> </h1>
  <a href="?locale=en">en</a>
  <a href="?locale=uk">uk</a>
  <c:set var="loc" value="${pageContext.response.locale}"/>

  <br><br>
  <table border="1">
    <thead>
    <th><spring:message code="firstName"/></th>
    <th><spring:message code="lastName"/></th>
    <th><spring:message code="LOGIN"/> </th>
    <th><spring:message code="phone"/> </th>
    <th><spring:message code="e-mail"/> </th>
    <th><spring:message code="address"/> </th>
    <th><spring:message code="accumulated_sum"/> </th>
    </thead>
    <c:forEach var="customer" items="${customers}">
      <tr>
        <td>${customer.firstName}</td>
        <td>${customer.lastName}</td>
        <td>${customer.user.name}</td>
        <td>${customer.contact.tel}</td>
        <td>${customer.contact.email}</td>
        <td>${customer.address}</td>
        <td>${customer.accumulativeCard.sum}</td>
        <td>
          <sec:authorize access="hasRole('ROLE_ADMIN')">
            <spring:message code="edit" var="edit"/>
            <form action="/restaurant/jsp/admin/cust/editcust" method="post">
              <input type="hidden" name="custid" value="${customer.id}" />
              <input type="submit" name ="send" value="${edit}" />
              <input type="hidden"
                     name="${_csrf.parameterName}"
                     value="${_csrf.token}"/>
            </form>
            <spring:message code="remove" var="remove"/>
            <form action="/restaurant/jsp/admin/cust/removecust" method="post">
              <input type="hidden" name="custid" value="${customer.id}" />
              <input type="submit" name ="send" value="${remove}" />
              <input type="hidden"
                     name="${_csrf.parameterName}"
                     value="${_csrf.token}"/>
            </form>
          </sec:authorize>
        </td>
      </tr>
    </c:forEach>
  </table>
  <a href="/restaurant/jsp/admin/cust/create/"><spring:message code="newCustomer"/></a>
  <c:url var="logoutUrl" value="/logout"/>
  <sec:authorize access="isFullyAuthenticated()">
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
