<%@ page 
	language="java" 
	contentType="text/html; charset=ISO-8859-1"
	import="javax.sql.rowset.CachedRowSet,oracle.jdbc.rowset.OracleCachedRowSet"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>List Of Movies</title>
</head>
<body>
<%
	String city=null;
	for (Cookie c : request.getCookies()){
		if (c.getName().equals("city")){
			city = c.getValue();
			break;
		}
	}
	if (city==(null)){
		response.sendRedirect("selectcity.jsp");
		return;
	}
%>
<h1>List of Movies - [<%=city%>]</h1>
<a href="selectcity.jsp">Change City</a>
<table border="1" width="100%">
	<tr>
		<th>Movie Name</th>
		<th>Release Date</th>
		<th>Language</th>
	</tr>
	<%
		CachedRowSet crs = new OracleCachedRowSet();
		crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
		crs.setUsername("hr");
		crs.setPassword("hr");
		crs.setCommand("select movie_name, lang, release_date from movies where city_name=?");
		crs.setString(1, city);
		crs.execute();
		while(crs.next()){
			out.println(String.format("<tr><td>%s</td><td>%s</td><td>%s</td></tr>", 
					crs.getString("movie_name"),
					crs.getString("release_date"),
					crs.getString("lang")));
		}
		crs.close();
	%>
</table>
</body>
</html>