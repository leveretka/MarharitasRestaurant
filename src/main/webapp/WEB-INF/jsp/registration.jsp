<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: margarita
  Date: 01.09.15
  Time: 15:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <title><spring:message code="registration"/></title>
    <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

    <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
    <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
    <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
    <div id="carte-1">
    <div id="registration">
        <h1><spring:message code="registration"/></h1>
        <%--<a href="?locale=en">en</a>--%>
        <%--<a href="?locale=uk">uk</a>--%>
        <c:set var="loc" value="${pageContext.response.locale}"/>

        <sec:authorize access="isAnonymous()">
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
            <input type="hidden" name="sum" value="0"/>

            <spring:message code="save" var="save"/>
            <input type="hidden" name="enabled" value="TRUE">
            <input type="submit" value="${save}"/>
            <input type="hidden"
                   name="${_csrf.parameterName}"
                   value="${_csrf.token}"/>
        </form>

    </sec:authorize>
<spring:message code="log_out" var="logout"/>
<c:url var="logoutUrl" value="/logout"/>
<sec:authorize access="isFullyAuthenticated()">
  <form method="post" action="${logoutUrl}">
    <input type="submit" value="${logout}" />
    <input type="hidden"
           name="${_csrf.parameterName}"
           value="${_csrf.token}"/>
  </form>
</sec:authorize>
</div>
        <c:if test="${errors != null}">
            <div id="error-panel">
                <ul>
                    <c:forEach var="error" items="${errors}">
                        <li>${error}</li>
                    </c:forEach>
                </ul>
            </div>
        </c:if>
    </div>
</body>
</html>
