<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Salary</title>
</head>
<body>
<h1>Update Salary</h1>
<form action="updatesalary.jsp">
	Employee id:<br><input type="text" value="${param.empid}" name="empid"/><br>
	Salary: <br><input type="text" value="${param.salary}" name="salary"/><br>
	<input type="submit" value="Update"/>
</form>
<%
	if (request.getParameter("empid")==null)
		return;
%>
<jsp:useBean id="emp" scope="page" class="beans.EmployeeBean"></jsp:useBean>
<jsp:setProperty property="*" name="emp"/>
<%
	if (emp.process()){
		out.println("<br>Updated Successfully!");
	}
	else{
		out.println("<br>Sorry! Could not update salary!");
	}
%>
</body>
</html>