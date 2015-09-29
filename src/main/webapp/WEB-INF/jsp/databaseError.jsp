<%-- 
    Document   : databaseError
    Created on : Aug 10, 2015, 6:04:23 PM
    Author     : andrii
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Database Error Page</title>
        <link href="/restaurant/resources/favicon.ico" rel="shortcut icon" />

        <link href='http://fonts.googleapis.com/css?family=Droid+Serif' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Dancing+Script' rel='stylesheet' type='text/css'>
        <link href='https://fonts.googleapis.com/css?family=Marck+Script&subset=latin,cyrillic' rel='stylesheet' type='text/css'>

        <link rel="stylesheet" href="/restaurant/resources/css/template.css" media="screen" />
        <link rel="stylesheet" href="/restaurant/resources/css/colorbox.css" />
        <link rel="stylesheet" href="/restaurant/resources/css/options.css" />

    </head>
    <body>
        <h1>Database Error Happened!</h1>
        Exception: ${ex}

    </body>
</html>
