<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
  <title>Order</title>
  <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

  <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
  <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
  <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
  <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
  <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>

<body>
<c:set var="loc" value="${pageContext.response.locale}"/>
<div class="wrapper">
  <div id="header">
    <h1><spring:message code="order"/> ${order.id} </h1>
    <%--<a href="?locale=en">en</a>--%>
    <%--<a href="?locale=uk">uk</a>--%>
  </div>
    <table border="1">
      <thead>
      <th><spring:message code="name"/></th>
      <th><spring:message code="price"/></th>
      <th><spring:message code="out"/></th>
      <th><spring:message code="measureType"/></th>
      <th><spring:message code="qnt"/></th>
      </thead>
      <c:forEach var="meal" items="${order.meals}">
        <tr>
          <td>${meal.key.getName(loc)}</td>
          <td>${meal.key.price}</td>
          <td>${meal.key.out}</td>
          <td><spring:message code="${meal.key.measureType}"/></td>
          <td>${meal.value}</td>
          <%--<td>--%>
            <%--<form action="/restaurant/jsp/order/removemeal" method="post">--%>
              <%--<input type="hidden" name="mealid" value="${meal.key.id}" />--%>
              <%--<input type="submit" name ="send" value=" - " />--%>
              <%--<input type="hidden"--%>
                     <%--name="${_csrf.parameterName}"--%>
                     <%--value="${_csrf.token}"/>--%>
            <%--</form>--%>
            <%--<form action="/restaurant/jsp/order/addmeal" method="post">--%>
              <%--<input type="hidden" name="mealid" value="${meal.key.id}" />--%>
              <%--<input type="hidden" name="redirect" value="order/previewOrder">--%>
              <%--<input type="submit" name ="send" value=" + " />--%>
              <%--<input type="hidden"--%>
                     <%--name="${_csrf.parameterName}"--%>
                     <%--value="${_csrf.token}"/>--%>
            <%--</form>--%>
          <%--</td>--%>
        </tr>
      </c:forEach>
    </table>

    <p>
      <spring:message code="totalCost"/> : ${order.price}
    </p>

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
