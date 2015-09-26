<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title><spring:message code="MRestaurant"/></title>
    <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

    <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
    <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
    <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>

<h1 id="greeting"><spring:message code="greeting"/></h1>
<div id="langs1">
    <a href="?locale=en">en</a>
    <a href="?locale=uk">uk</a>
    <c:set var="loc" value="${pageContext.response.locale}"/>
</div>
<div class="menu">



    <sec:authorize access="isAnonymous()">
        <a href="/restaurant/jsp/cust/register"><spring:message code="reg"/></a>
        <a href="/restaurant/login"><spring:message code="log"/></a>
        <a href="/restaurant/jsp/meal/"><spring:message code="menu"/></a>
    </sec:authorize>
    <sec:authorize access="hasRole('ROLE_USER')">

        <a href="/restaurant/jsp/meal/"><spring:message code="menu"/></a>
    </sec:authorize>
    <sec:authorize access="hasRole('ROLE_ADMIN')">

        <a href="/restaurant/jsp/admin/"><spring:message code="Administrator's MENU"/></a>
    </sec:authorize>
    <c:url var="logoutUrl" value="/logout"/>
    <%--<div id="logout">--%>
        <%--<sec:authorize access="isFullyAuthenticated()">--%>
            <%--<form method="post" action="${logoutUrl}">--%>
                <%--<input type="submit" value="Log out" />--%>
                <%--<input type="hidden"--%>
                    <%--name="${_csrf.parameterName}"--%>
                    <%--value="${_csrf.token}"/>--%>
            <%--</form>--%>
        <%--</sec:authorize>--%>
    <%--</div>--%>
</div>
<img src="/restaurant/resources/images/main.png" alt="Marharita's Restaurant" />
</body>
</html>