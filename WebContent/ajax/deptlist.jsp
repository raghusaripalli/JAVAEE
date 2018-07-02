<%@ page language="java" 
	import="javax.sql.rowset.CachedRowSet,oracle.jdbc.rowset.OracleCachedRowSet"
	import ="javax.json.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	String deptid = request.getParameter("deptid");
	if (deptid==null || deptid=="") {
		return;
	}
	JsonObjectBuilder b = Json.createObjectBuilder();
	CachedRowSet crs = new OracleCachedRowSet();
	crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
	crs.setUsername("hr");
	crs.setPassword("hr");
	crs.setCommand("select department_name, manager_id, location_id from departments where manager_id=?");
	crs.setString(1, deptid);
	crs.execute();
	if (crs.size()==0){
		b.add("error", "Department_id Not Found");	
	}
	else{
		while(crs.next()){
			b.add("department_name",crs.getString(1));
			b.add("manager_id",crs.getString(2));
			b.add("location_id",crs.getString(3));
		}
	}
	out.println(b.build().toString());
	crs.close();
%>