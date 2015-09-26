<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Menu</title>
  <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

  <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
  <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
  <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>

<div class="wrapper">
  <h1><spring:message code="menu" /></h1>

  <a href="?locale=en">en</a>
  <a href="?locale=uk">uk</a>
  <c:set var="loc" value="${pageContext.response.locale}"/>
  <br>
  <div id="buttons-hbox">
  <a href="all"><spring:message code="all"/></a>
  <a href="alcohol"><spring:message code="alcohol"/></a>
  <a href="soft_drink"><spring:message code="soft"/></a>
  <a href="hot_dish"><spring:message code="hot"/></a>
  <a href="side_dish"><spring:message code="side"/></a>
  <a href="garnish"><spring:message code="garnish"/></a>
  <a href="dessert"><spring:message code="dessert"/></a>
  <a href="soup"><spring:message code="soup"/></a>
  <a href="pizza"><spring:message code="pizza"/></a>
  </div>
  <br><br>
  <table border="1">
    <thead>
      <th><spring:message code="name" /></th>
      <th><spring:message code="price" /></th>
      <th><spring:message code="out" /></th>
      <th><spring:message code="measureType" /></th>
      <sec:authorize access="hasRole('ROLE_USER')">
        <th><spring:message code="add" /></th>
      </sec:authorize>
    </thead>
    <c:forEach var="meal" items="${meals}">
      <tr>
        <td>${meal.getName(loc)}</td>
        <td>${meal.price}</td>
        <td>${meal.out}</td>
        <td><spring:message code="${meal.measureType}"/></td>

        <sec:authorize access="hasRole('ROLE_USER')">

        <td>
          <form action="/restaurant/jsp/order/addmeal" method="post">
            <input type="hidden" name="mealid" value="${meal.id}" />
            <input type="submit" name ="send" value=" + " />
            <input type="hidden" name="redirect" value="meal/">
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>
          </form>
        </td>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">

          <td>
            <form action="/restaurant/jsp/order/addmeal" method="post">
              <input type="hidden" name="mealid" value="${meal.id}" />
              <input type="submit" name ="send" value=" + " />
              <input type="hidden" name="redirect" value="meal/">
              <input type="hidden"
                     name="${_csrf.parameterName}"
                     value="${_csrf.token}"/>
            </form>
          </td>
        </sec:authorize>
      </tr>
    </c:forEach>
  </table>
  <spring:message code="preview" var="preview"/>
  <form action="/restaurant/jsp/order/previewOrder" method="post">
    <input type="submit" value="${preview}">
    <input type="hidden"
           name="${_csrf.parameterName}"
           value="${_csrf.token}"/>
  </form>

  <a href="/restaurant/"><spring:message code="home"/></a>
<sec:authorize access="hasRole('ROLE_USER')">
  <a href="/restaurant/jsp/cust/cabinet/"><spring:message code="cabinet"/></a>
</sec:authorize>
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

</body>
</html>
