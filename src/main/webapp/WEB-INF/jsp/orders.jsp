<%--
  Created by IntelliJ IDEA.
  User: margarita
  Date: 03.09.15
  Time: 13:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title></title>
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
    <h1><spring:message code="orders"/> </h1>
<br>
<a href="?locale=en">en</a>
<a href="?locale=uk">uk</a>
<c:set var="loc" value="${pageContext.response.locale}"/>

<table border="1" id="order_items_table">
    <thead>
    <th>ID</th>
    <th><spring:message code="firstName"/> </th>
    <th><spring:message code="lastName"/> </th>
    <th><spring:message code="LOGIN"/></th>
    <th><spring:message code="phone"/></th>
    <th><spring:message code="e-mail"/></th>
    <th><spring:message code="address"/></th>
    <th><spring:message code="date"/></th>
    <th><spring:message code="totalCost"/></th>
    <th><spring:message code="status"/></th>
    </thead>

<c:forEach var="order" items="${orders}">


    <tr>
        <td>${order.id}</td>
        <td>${order.customer.firstName}</td>
        <td>${order.customer.lastName}</td>
        <td>${order.customer.user.name}</td>
        <td>${order.contact.tel}</td>
        <td>${order.contact.email}</td>
        <td>${order.address}</td>
        <td>${order.date}</td>
        <td>${order.price}</td>
        <td><spring:message code="${order.status}"/></td>
        <td>
            <spring:message code="accept" var="accept"/>
            <spring:message code="decline" var="decline"/>
            <spring:message code="details" var="details"/>
            <spring:message code="deliver" var="deliver"/>

            <c:if test="${order.status == 'NEW'}">
                <form action="/restaurant/jsp/admin/order/acceptorder" method="post">
                    <input type="hidden" name="orderid" value="${order.id}">
                    <input type="submit" value="${accept}">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                </form>
                <form action="/restaurant/jsp/admin/order/declineorder" method="post">
                    <input type="hidden" name="orderid" value="${order.id}">
                    <input type="submit" value="${decline}">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                </form>
            </c:if>

            <c:if test="${order.status == 'PAYED'}">
                <form action="/restaurant/jsp/admin/order/deliverorder" method="post">
                    <input type="hidden" name="orderid" value="${order.id}">
                    <input type="submit" value="${deliver}">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                </form>
            </c:if>
            <c:if test="${order.status == 'ACCEPTED' and order.customer==null}">
                <form action="/restaurant/jsp/admin/order/deliverorder" method="post">
                    <input type="hidden" name="orderid" value="${order.id}">
                    <input type="submit" value="${deliver}">
                    <input type="hidden"
                           name="${_csrf.parameterName}"
                           value="${_csrf.token}"/>
                </form>
            </c:if>
            <form action="/restaurant/jsp/admin/order/details" method="post">
                <input type="hidden" name="orderid" value="${order.id}">
                <input type="submit" value="${details}">
                <input type="hidden"
                       name="${_csrf.parameterName}"
                       value="${_csrf.token}"/>
            </form>

        </td>
        <%--<table border="1">--%>
            <%--<thead><tr>--%>
                <%--<th><spring:message code="name"/></th>--%>
                <%--<th><spring:message code="mealType"/></th>--%>
                <%--<th><spring:message code="out"/></th>--%>
                <%--<th><spring:message code="measureType"/></th>--%>
                <%--<th><spring:message code="price"/> </th>--%>
                <%--<th><spring:message code="qnt"/></th>--%>
            <%--</tr></thead>--%>

            <%--<c:forEach var="entry" items="${order.meals}">--%>
                <%--<tr>--%>
                    <%--<td>${entry.key.name}</td>--%>
                    <%--<td>${entry.key.mealType}</td>--%>
                    <%--<td>${entry.key.out}</td>--%>
                    <%--<td>${entry.key.measureType}</td>--%>
                    <%--<td>${entry.key.price}</td>--%>
                    <%--<td>${entry.value}</td>--%>
                <%--</tr>--%>

             <%--</c:forEach>--%>
        <%--</table>--%>
    <%--<br>--%>
</c:forEach>
</table>
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