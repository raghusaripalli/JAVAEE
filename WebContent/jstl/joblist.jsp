<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Jobs List</title>
</head>
<body>
<h1>Jobs List using JSTL Tags</h1>
<sql:setDataSource 
	var="oracle"
	driver="oracle.jdbc.driver.OracleDriver"
	url="jdbc:oracle:thin:@localhost:1521:xe"
	user="hr" password="hr"/>

<sql:query var="list" dataSource="${oracle}">
select job_title,max_salary from jobs
</sql:query>
<ul>
<c:forEach var="i" items="${list.rows}">
	<li>${i.job_title}, ${i.max_salary}</li>
</c:forEach>
</ul>
</body>
</html>