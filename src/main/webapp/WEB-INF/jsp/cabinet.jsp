<%--
  Created by IntelliJ IDEA.
  User: margarita
  Date: 01.09.15
  Time: 15:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<html>
<head>
    <title><spring:message code="cabinet"/> </title>
    <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

    <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Marck+Script&subset=latin,cyrillic' rel='stylesheet' type='text/css'>

    <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
    <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
    <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<div id="carte">
<div id="main">
    <h2><spring:message code="my_ords"/></h2>
    <br>
    <c:if test="${errors == null}">
        <a href="?locale=en">en</a>
        <a href="?locale=uk">uk</a>
    </c:if>
    <c:set var="loc" value="${pageContext.response.locale}"/>

    <table border="1">
        <thead>
        <th><spring:message code="phone"/></th>
        <th><spring:message code="e-mail"/> </th>
        <th><spring:message code="address"/></th>
        <th><spring:message code="date"/></th>
        <th><spring:message code="totalCost"/></th>
        <th><spring:message code="status"/></th>
        </thead>
    <c:forEach var="order" items="${orders}">


            <tr>
                <td>${order.contact.tel}</td>
                <td>${order.contact.email}</td>
                <td>${order.address}</td>
                <td>${order.date}</td>
                <td>${order.price}</td>
                <td><spring:message code="${order.status}"/></td>
                <td>
                    <spring:message code="cancel" var="cancel"/>
                    <c:if test="${order.status == 'NEW' or order.status == 'ACCEPTED'}">
                        <form action="/restaurant/jsp/order/cancelorder" method="post">
                            <input type="hidden" name="orderid" value="${order.id}">
                            <input type="submit" value="${cancel}">
                            <input type="hidden"
                                   name="${_csrf.parameterName}"
                                   value="${_csrf.token}"/>
                        </form>
                    </c:if>

                    <spring:message code="pay" var="pay"/>

                    <c:if test="${order.status == 'ACCEPTED'}">
                        <form action="/restaurant/jsp/order/payorder" method="post">
                            <input type="hidden" name="orderid" value="${order.id}">
                            <input type="submit" value="${pay}">
                            <input type="hidden"
                                   name="${_csrf.parameterName}"
                                   value="${_csrf.token}"/>
                        </form>
                    </c:if>

                    <spring:message code="resend" var="resend"/>
                    <c:if test="${order.status == 'DECLINED' or order.status == 'CANCELLED'}">
                        <form action="/restaurant/jsp/order/resendorder" method="post">
                            <input type="hidden" name="orderid" value="${order.id}">
                            <input type="submit" value="${resend}">
                            <input type="hidden"
                                   name="${_csrf.parameterName}"
                                   value="${_csrf.token}"/>
                        </form>
                    </c:if>
                    <c:set var="action" value="/restaurant/jsp/order/${order.id}" />
                    <a href="${action}"><spring:message code="details"/></a>
                    <%--<form action="${action}" method="get">--%>
                        <%--<input type="submit" value="details">--%>
                        <%--<input type="hidden"--%>
                               <%--name="${_csrf.parameterName}"--%>
                               <%--value="${_csrf.token}"/>--%>
                    <%--</form>--%>



                </td>
                </tr>
    </c:forEach>
    </table>
</div>

<div id="personal">
    <h2><spring:message code="personal"/></h2>
    <form action="/restaurant/jsp/cust/addnew/" method="post">

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
        <spring:message code="accumulated_sum"/> : ${customer.accumulativeCard.sum}
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


        <spring:message code="save" var="save"/>
        <input type="hidden" name="sum" value="${customer.accumulativeCard.sum}"/>

        <input type="hidden" name="enabled" value="TRUE">
        <input type="submit" value="${save}"/>
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}"/>
    </form>

    <spring:message code="log_out" var="logout"/>
    <c:url var="logoutUrl" value="/logout"/>
    <form class="out" method="post" action="${logoutUrl}">
        <input type="submit" value="${logout}" />
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}"/>
    </form>

</div>
</div>
</body>
</html>
