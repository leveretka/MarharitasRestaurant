<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>JSP Page</title>
  <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

  <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
  <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
  <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<fmt:setBundle basename="text" var="lang"/>
<fmt:setLocale value="${locale}"/>

<div class="wrapper">
  <h1>CUSTOMERS</h1>

  <br><br>
  <table border="1">
    <thead>
    <th>FIRST NAME</th>
    <th>LAST NAME</th>
    <th>LOGIN</th>
    <th>TELEPHONE</th>
    <th>E-MAIL</th>
    <th>ADDRESS</th>
    <th>SUM</th>
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
            <form action="/restaurant/jsp/admin/cust/editcust" method="post">
              <input type="hidden" name="custid" value="${customer.id}" />
              <input type="submit" name ="send" value="edit" />
              <input type="hidden"
                     name="${_csrf.parameterName}"
                     value="${_csrf.token}"/>
            </form>
            <form action="/restaurant/jsp/admin/cust/removecust" method="post">
              <input type="hidden" name="custid" value="${customer.id}" />
              <input type="submit" name ="send" value="remove" />
              <input type="hidden"
                     name="${_csrf.parameterName}"
                     value="${_csrf.token}"/>
            </form>
          </sec:authorize>
        </td>
      </tr>
    </c:forEach>
  </table>
  <a href="/restaurant/jsp/admin/cust/create/">Add new customer</a>

</div>
</body>
</html>
