<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" type="text/css" href="estilos/style.css" />
<title>Logout</title>

<%Session.Contents.RemoveAll()%>


<!--#include file="includes/body.asp"-->
<!--#include file="includes/mod_no_logueado.asp"-->
<!--#include file="includes/funciones.asp"-->

</head>

<body>
<%
Session.Contents.RemoveAll()
Response.Redirect("default.asp")
%>

</body>
</html>
