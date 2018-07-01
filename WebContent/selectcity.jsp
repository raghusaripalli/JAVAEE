<%@ page 
	language="java" 
	import="javax.sql.rowset.CachedRowSet,oracle.jdbc.rowset.OracleCachedRowSet"
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Select City</title>
</head>
<body>
<h1>Select your City</h1>
<form action="savecity.jsp">
City <select name="cities">
<%
	CachedRowSet crs = new OracleCachedRowSet();
	crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
	crs.setUsername("hr");
	crs.setPassword("hr");
	crs.setCommand("select distinct(city_name) from movies");
	crs.execute();
	String city= "";
	while(crs.next()){
		city = crs.getString("city_name");
		out.println("<option value="+city+">"+city+"</option>");
	}
	crs.close();
%>
</select><p />
<input type="submit" value="Save" />
</form>
</body>
</html>