<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert into Job Table</title>
</head>
<body>
<h1>Create new Job using JSTL</h1>

<!-- form to create job in table -->
<form action="createjob.jsp" method="post">
	Job ID: <input type="text" value="${ param.jobid }" name="jobid" required/> <p/>
	Job Title: <input type="text" value="${ param.jobtitle }" name="jobtitle" required/> <p/>
	Min Salary:<input type="number" name="minsal" value="${ param.minsal }" required/> <p/>
	Max Salary:<input type="number" value="${ param.maxsal }" name="maxsal" required/><p/>
	<input value="Create Job" type="submit" />
</form>

<!-- connect to oracle database -->
<sql:setDataSource var="oracle"
	driver="oracle.jdbc.driver.OracleDriver"
	url="jdbc:oracle:thin:@localhost:1521:xe"
	user="hr" password="hr"/>

<%
	String jobid = request.getParameter("jobid");
	if (jobid==null || jobid=="")
		return;
%>

<!-- catch exception and store value in ex -->
<c:catch var="ex">
	<sql:update var="nrows" dataSource="${ oracle }">
		insert into jobs values(?,?,?,?)
		<sql:param>${ param.jobid }</sql:param>
		<sql:param>${ param.jobtitle }</sql:param>
		<sql:param>${ param.minsal }</sql:param>
		<sql:param>${ param.maxsal }</sql:param>
	</sql:update>
</c:catch>

<!-- show error if ex is not empty -->
<c:if test="${!empty pageScope.ex }">
	<h4>Error: ${ pageScope.ex.message }</h4>
</c:if>

<c:if test="${ nrows == 1 }">
	<h4>Successfully created new Job</h4>
</c:if>
</body>
</html>