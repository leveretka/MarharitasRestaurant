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

<%--<jsp:useBean id="type" type="MealType" />--%>
<%--<jsp:useBean id="measureType" type="MeasureType" />--%>

<html>
<head>
    <title>Meal ${meal.name}</title>
    <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

    <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
    <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
    <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

</head>
<body>
    <h1>Meal ${meal.name}</h1>

    <form action="/restaurant/jsp/admin/meal/addnew/" method="post">

        <input type="hidden" name="id" value="${meal.id}"/>

        NAME : <input type="text" name="name" value="${meal.name}"/>
        <br>
        TYPE :
        <select name="mealType">
            <c:forEach items="${types}" var="item">
                <option value="${item}">${item}</option>
            </c:forEach>

        </select>
        <br>
        OUT : <input type="number" name="out" value="${meal.out}"/>
        <br>
        MEASURE :
        <select name="measureType">
            <c:forEach items="${measures}" var="item">
                <option value="${item}">${item}</option>
            </c:forEach>

        </select>
        <br>
        PRICE : <input type="number" name="price" value="${meal.price}"/>
        </br>
        <input type="submit" value="save"/>
        <input type="hidden"
               name="${_csrf.parameterName}"
               value="${_csrf.token}"/>
    </form>

</body>
</html>
