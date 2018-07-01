<%@ page 
	language="java" 
	import="javax.sql.rowset.CachedRowSet,oracle.jdbc.rowset.OracleCachedRowSet"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee By Job</title>
</head>
<body>
<h1>Employee By Job</h1>
<form action="empbyjob.jsp">
	Job Id: <input type="text" name="jobid" value="${param.jobid}"/>
	<input type="submit" value="Employees"/>
</form>
<%
	if (request.getParameter("jobid")==null)
		return;
	
	String jobid = request.getParameter("jobid");
	CachedRowSet crs = new OracleCachedRowSet();
	crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
	crs.setUsername("hr");
	crs.setPassword("hr");
	crs.setCommand("select first_name, hire_date, salary, department_id from employees where job_id=?");
	crs.setString(1, jobid);
	crs.execute();
	if (crs.size()>0){
		out.println("<h1>Results</h1><table width=100% border=1><tr><th>First Name</th><th>Hire Date</th><th>Salary</th><th>Department Id</th></tr>");
		while (crs.next()){
			out.println("<tr>");
			out.println("<td>" + crs.getString("first_name") + "</td>");
			out.println("<td>" + crs.getString("hire_date") + "</td>");
			out.println("<td>" + crs.getInt("salary") + "</td>");
			out.println("<td>" + crs.getInt("department_id") + "</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	}
	else{
		out.println("<br/><p>Sorry! Invalid Job Id</p>");
	}
	crs.close();
	
%>
</body>
</html>