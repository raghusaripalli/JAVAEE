<%@ page contentType="text/html; charset=ISO-8859-1" 
	import="javax.sql.rowset.*,javax.json.*,oracle.jdbc.rowset.*" %>
<%
	// Using CachedRowSet to fetch job data from db
	CachedRowSet crs = new OracleCachedRowSet();
	crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
	crs.setUsername("hr");
	crs.setPassword("hr");
	crs.setCommand("select job_id, job_title from jobs");
	crs.execute();
	
	// Creating an Array of JSON Objects
	JsonArrayBuilder a = Json.createArrayBuilder();
	while(crs.next()){
		JsonObjectBuilder b = Json.createObjectBuilder();
		b.add("id",crs.getString("job_id"));
		b.add("title",crs.getString("job_title"));
		a.add(b.build());
	}
	// desired output will be [{"id":"AD_PRES","title":"President"}, ... ]
	out.print(a.build().toString());
	crs.close();
%>