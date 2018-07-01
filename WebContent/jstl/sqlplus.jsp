<%@ page 
	language="java" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!-- include JSTL tags -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SqL Plus</title>
</head>
<body>
<h1>SQL Plus</h1>

<!-- form to enter query -->
<form action="sqlplus.jsp" method="post">
	<textarea rows="3" cols="50" name="query">${ param.query }</textarea><p/>
	<input value="Execute" type="submit" />
</form>

<!-- terminate JSP if query param is null or empty -->
<%
	String query = request.getParameter("query");
	if (query==null || query=="")
		return;
%>

<!-- connect to oracle database -->
<sql:setDataSource var="oracle"
	driver="oracle.jdbc.driver.OracleDriver"
	url="jdbc:oracle:thin:@localhost:1521:xe"
	user="hr" password="hr"/>

<!-- catch exception and store value in ex -->
<c:catch var="ex">
	<sql:query var="list" dataSource="${ oracle }">
		${param.query}
	</sql:query>
</c:catch>

<!-- show error if ex is not empty -->
<c:if test="${!empty pageScope.ex }">
	<h4>Error: ${ pageScope.ex.message }</h4>
</c:if>

<!-- display data table if ex is empty -->
<c:if test="${ empty pageScope.ex }">
	<table border="1" width="100%s">
	<tr>
	<c:forEach var="colname" items="${ list.columnNames }">
		<th>${ colname }</th>
	</c:forEach>
	</tr>
	<c:forEach var="row" items="${list.rowsByIndex}">
		<tr>
		<c:forEach var="col" items="${row}">
			<td>${ col }</td>
		</c:forEach>
		</tr>
	</c:forEach>
	</table>
</c:if>
</body>
</html>