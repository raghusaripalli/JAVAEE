<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	import="javax.sql.rowset.CachedRowSet,oracle.jdbc.rowset.OracleCachedRowSet"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Employee</title>
</head>
<body>
<form action="searchemployee.jsp">
	Name: <br><input type="text" name="name" value="${param.name}"/><p/>
	Salary: <br>
	<input type="text" name="lowsal" value="${ param.lowsal }"/> 
	to
	<input type="text" name="highsal" value="${ param.highsal }"/> <p/>
	<input type="submit" value="Search" />
</form>
<%
	String name = request.getParameter("name");
	String lsal = request.getParameter("lowsal");
	String hsal = request.getParameter("highsal");
	boolean nameFlag = name==null||name=="";
	boolean salaryFlag = (lsal==null||lsal==""||hsal==null||hsal=="");
	int i=1;
	String cmd = " select concat(concat(first_name,' '),last_name) as name, hire_date, salary, department_id from employees where ";
	if (nameFlag && salaryFlag)
	{
		out.println("<p/> Please enter either name of salary range");
		return;
	}
	CachedRowSet crs = new OracleCachedRowSet();
	crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
	crs.setUsername("hr");
	crs.setPassword("hr");
	if (!nameFlag){ 
		cmd += "(first_name=? or last_name=?)";
		crs.setString(i++, name);
		crs.setString(i++, name);
	}
	if (!nameFlag && !salaryFlag) cmd+=" and ";
	if (!salaryFlag){ 
		cmd +="salary between ? and ?";
		crs.setString(i++, lsal);
		crs.setString(i++, hsal);
	}
	System.out.println(cmd);
	crs.setCommand(cmd);
	crs.execute();
	if (crs.size()>0){
		out.println("<h1>Results</h1><table width=100% border=1><tr><th>Name</th><th>Hire Date</th><th>Salary</th><th>Department Id</th></tr>");
		while (crs.next()){
			out.println("<tr>");
			out.println("<td>" + crs.getString("name") + "</td>");
			out.println("<td>" + crs.getString("hire_date") + "</td>");
			out.println("<td>" + crs.getInt("salary") + "</td>");
			out.println("<td>" + crs.getInt("department_id") + "</td>");
			out.println("</tr>");
		}
		out.println("</table>");
	}
	else{
		out.println("<p/>Sorry! No records found!");
	}
	crs.close();
%>
</body>
</html>