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
<fmt:setLocale value="en_US"/>

<div class="wrapper">
  <h1>ALL MEALS</h1>
  </form>
  <br><br>
  <table border="1">
    <thead>
    <th><fmt:message key="name" bundle="${lang}"/></th>
    <th>TYPE</th>
    <th><fmt:message key="out" bundle="${lang}"/></th>
    <th><fmt:message key="measureType" bundle="${lang}"/></th>
    <th><fmt:message key="price" bundle="${lang}"/></th>
    </thead>
    <c:forEach var="meal" items="${meals}">
      <tr>
        <td>${meal.name}</td>
        <td>${meal.mealType}</td>
        <td>${meal.out}</td>
        <td>${meal.measureType}</td>
        <td>${meal.price}</td>
        <td>
          <sec:authorize access="hasRole('ROLE_ADMIN')">
            <form action="/restaurant/jsp/admin/meal/editmeal" method="post">
              <input type="hidden" name="mealid" value="${meal.id}" />
              <input type="submit" name ="send" value="edit" />
              <input type="hidden"
                     name="${_csrf.parameterName}"
                     value="${_csrf.token}"/>
            </form>
            </form>
            <form action="/restaurant/jsp/admin/meal/removemeal" method="post">
              <input type="hidden" name="mealid" value="${meal.id}" />
              <input type="submit" name ="send" value="remove" />
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

  <a href="/restaurant/jsp/admin/meal/create/">Add new meal</a>

</div>
</body>
</html>
