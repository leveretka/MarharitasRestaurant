<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page</title>
        <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

        <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
        <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
        <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

    </head>
    <body>
        <h1>Error happened</h1>
        <h2>${ex}</h2>
        <h3>${ex.printStackTrace()}</h3>
    </body>
</html>
