<%@ page contentType="text/html; charset=ISO-8859-1" 
	import="javax.sql.rowset.*,javax.json.*,oracle.jdbc.rowset.*" %>
<%
	// Fetch job_id parameter
	String job_id = request.getParameter("job_id");

	// If job_id param is null or empty terminate the jsp
	if (job_id==null || job_id=="")
		return;
	
	// using CachedRowSet to fetch employees data from db
	CachedRowSet crs = new OracleCachedRowSet();
	crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
	crs.setUsername("hr");
	crs.setPassword("hr");
	crs.setCommand("select first_name ||' '||last_name fullname from employees where job_id=?");
	crs.setString(1, job_id);
	crs.execute();
	
	// Creating an Array of Strings like ["Alexander Hunold", ... ]
	JsonArrayBuilder a = Json.createArrayBuilder();
	while(crs.next()){
		a.add(crs.getString("fullname"));
	}
	out.print(a.build().toString());
	crs.close();
%>