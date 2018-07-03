<%@ page contentType="text/html; charset=ISO-8859-1" 
	import="javax.sql.rowset.*,javax.json.*,oracle.jdbc.rowset.*" %>
<%
	
	// using CachedRowSet to fetch employees data from db
	CachedRowSet crs = new OracleCachedRowSet();
	crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
	crs.setUsername("hr");
	crs.setPassword("hr");
	crs.setCommand("select department_id, department_name from departments");
	crs.execute();
	
	// Creating an Array of JSON Objects
	JsonArrayBuilder a = Json.createArrayBuilder();
	while(crs.next()){
		JsonObjectBuilder b =  Json.createObjectBuilder();
		b.add("id",crs.getString("department_id"));
		b.add("name",crs.getString("department_name"));
		a.add(b.build());
	}
	out.print(a.build().toString());
	crs.close();
%>