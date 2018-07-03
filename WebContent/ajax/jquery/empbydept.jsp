<%@ page contentType="text/html; charset=ISO-8859-1" 
	import="javax.sql.rowset.*,javax.json.*,oracle.jdbc.rowset.*" %>
<%
	//Thread.sleep(5000);
	// Fetch job_id parameter
	String dept_id = request.getParameter("dept_id");

	// If job_id param is null or empty terminate the jsp
	if (dept_id==null || dept_id=="")
		return;
	
	// using CachedRowSet to fetch employees data from db
	CachedRowSet crs = new OracleCachedRowSet();
	crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
	crs.setUsername("hr");
	crs.setPassword("hr");
	String q = "select employee_id, first_name ||' '||last_name fullname, to_char(hire_date,'dd-MON-yy') hdate, salary, (select job_title from jobs where job_id=e.job_id) job from employees e where department_id=?";
	crs.setCommand(q);
	crs.setString(1, dept_id);
	crs.execute();
	
	// Creating an Array of JSON Objects like 
	// [{"id":"120","fullname":"..","doj":"..","salary":"...","job":".."}, {...}, ... ]
	JsonArrayBuilder a = Json.createArrayBuilder();
	while(crs.next()){
		JsonObjectBuilder b = Json.createObjectBuilder();
		b.add("id",crs.getString("employee_id"));
		b.add("fullname", crs.getString("fullname"));
		b.add("doj",crs.getString("hdate"));
		b.add("salary",crs.getString("salary"));
		b.add("job",crs.getString("job"));
		a.add(b.build());
	}
	out.print(a.build().toString());
	crs.close();
%>