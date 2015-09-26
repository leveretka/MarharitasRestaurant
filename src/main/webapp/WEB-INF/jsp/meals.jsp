<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
  <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
  <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
  <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<div class="wrapper">
  <h1><spring:message code="MEALS"/></h1>
  <a href="?locale=en">en</a>
  <a href="?locale=uk">uk</a>
  <c:set var="loc" value="${pageContext.response.locale}"/>
<br><br>
  <table border="1">
    <thead>
    <th><spring:message code="name"/></th>
    <th><spring:message code="mealType"/></th>
    <th><spring:message code="out"/></th>
    <th><spring:message code="measureType"/> </th>
    <th><spring:message code="price"/></th>
    <th><spring:message code="ua"/></th>
    </thead>
    <c:forEach var="meal" items="${meals}">
      <tr>
        <td>${meal.name}</td>
        <td><spring:message code="${meal.mealType.toString().toLowerCase()}"/></td>
        <td>${meal.out}</td>
        <td><spring:message code="${meal.measureType}"/></td>
        <td>${meal.price}</td>
        <td>${meal.nameUa}</td>
        <td>
          <sec:authorize access="hasRole('ROLE_ADMIN')">
            <spring:message code="edit" var="edit"/>
            <form action="/restaurant/jsp/admin/meal/editmeal" method="post">
              <input type="hidden" name="mealid" value="${meal.id}" />
              <input type="submit" name ="send" value="${edit}" />
              <input type="hidden"
                     name="${_csrf.parameterName}"
                     value="${_csrf.token}"/>
            </form>
            </form>
            <spring:message code="remove" var="remove"/>
            <form action="/restaurant/jsp/admin/meal/removemeal" method="post">
              <input type="hidden" name="mealid" value="${meal.id}" />
              <input type="submit" name ="send" value="${remove}" />
              <input type="hidden"
                     name="${_csrf.parameterName}"
                     value="${_csrf.token}"/>
            </form>
            </form>
          </sec:authorize>
        </td>
      </tr>
    </c:forEach>
  </table>

  <div class="down">
  <a href="/restaurant/jsp/admin/meal/create/"><spring:message code="newMeal"/></a>
    <br>
  <a href="/restaurant/"><spring:message code="home"/></a>

  <c:url var="logoutUrl" value="/logout"/>
  <spring:message code="log_out" var="logout"/>
  <sec:authorize access="isFullyAuthenticated()">
    <form method="post" action="${logoutUrl}">
      <input type="submit" value="${logout}" />
      <input type="hidden"
             name="${_csrf.parameterName}"
             value="${_csrf.token}"/>
    </form>
  </sec:authorize>
</div>
</div>
</body>
</html>