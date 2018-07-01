<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Save City</title>
</head>
<body>
<%
	String city = request.getParameter("cities");
	Cookie c = new Cookie("city", city);
	c.setMaxAge(7*24*60*60);
	response.addCookie(c);
	response.sendRedirect("listmovies.jsp");
%>
</body>
</html>