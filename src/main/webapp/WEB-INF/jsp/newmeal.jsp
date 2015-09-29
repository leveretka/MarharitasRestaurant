<%--
  Created by IntelliJ IDEA.
  User: margarita
  Date: 02.09.15
  Time: 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%--<jsp:useBean id="type" type="MealType" />--%>
<%--<jsp:useBean id="measureType" type="MeasureType" />--%>

<html>
<head>
    <title>Meal ${meal.name}</title>
    <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

    <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Marck+Script&subset=latin,cyrillic' rel='stylesheet' type='text/css'>

    <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
    <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
    <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
<div class="editor">
    <h1><spring:message code="meal"/> ${meal.name}</h1>
    <c:set var="loc" value="${pageContext.response.locale}"/>

    <form action="/restaurant/jsp/admin/meal/addnew/" method="post">

        <input type="hidden" name="id" value="${meal.id}"/>

        <spring:message code="name"/> : <input type="text" name="name" value="${meal.name}"/>
        <br>
        <spring:message code="mealType"/> :
        <select name="mealType">
            <c:if test="${meal.id != null}">
                <option selected="selected"><spring:message code="${meal.mealType.toString().toLowerCase()}"/></option>
            </c:if>
            <c:forEach items="${types}" var="item">
                <option value="${item}"><spring:message code="${item.toString().toLowerCase()}"/></option>
            </c:forEach>

        </select>
        <br>
        <spring:message code="out"/> : <input type="number" name="out" value="${meal.out}"/>
        <br>
        <spring:message code="measureType"/> :
        <select name="measureType">
        <c:if test="${meal.id != null}">
            <option selected="selected"><spring:message code="${meal.measureType}"/></option>
        </c:if>
            <c:forEach items="${measures}" var="item">
                <option value="${item}"><spring:message code="${item}"/></option>
            </c:forEach>

        </select>
        <br>
        <spring:message code="price"/> : <input type="number" name="price" value="${meal.price}"/>
        </br>

        <spring:message code="ua"/> : <input type="text" name="nameUa" value="${meal.nameUa}"/>
        </br>
        <spring:message code="save" var="save"/>
        <input type="submit" value="${save}"/>
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}"/>
    </form>
</div>
</body>
</html>
