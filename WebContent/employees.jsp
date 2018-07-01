<%@ page language="java"
		 import="javax.sql.rowset.CachedRowSet,oracle.jdbc.rowset.OracleCachedRowSet"
		 contentType="text/html; charset=ISO-8859-1"
    	 pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee Data</title>
</head>
<body>
<h1>Employee Data</h1>
<table border="3">
	<tr>
		<th>Employee ID</th>
		<th>First Name</th>
		<th>Salary</th>
	</tr>
<%
	int deptid = Integer.parseInt(request.getParameter("deptId"));
CachedRowSet crs = new OracleCachedRowSet();
try{
	
	crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
	crs.setUsername("hr");
	crs.setPassword("hr");
	crs.setCommand("select employee_id, first_name, salary from employees where department_id=?");
	crs.setInt(1, deptid);
	crs.execute();
}catch(Exception ex){
	ex.printStackTrace();
}
	
	while (crs.next()){
		out.println("<tr>");
		out.println("<td>" + crs.getInt("employee_id") + "</td>");
		out.println("<td>" + crs.getString("first_name") + "</td>");
		out.println("<td>" + crs.getInt("salary") + "</td>");
		out.println("</tr>");
	}
	crs.close();
%>
</table>
</body>
</html>