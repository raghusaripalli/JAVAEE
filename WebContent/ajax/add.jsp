<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!-- Write Simple Text -->
<% 
	int n1, n2;
	n1 = Integer.parseInt(request.getParameter("num1"));
	n2 = Integer.parseInt(request.getParameter("num2"));
	out.println(n1+n2);
%>