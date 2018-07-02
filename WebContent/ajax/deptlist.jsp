<%@ page language="java" 
	import="javax.sql.rowset.CachedRowSet,oracle.jdbc.rowset.OracleCachedRowSet"
	import ="javax.json.*" 
	contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	// Terminate JSP if deptid paramter is not given
	String deptid = request.getParameter("deptid");
	if (deptid==null || deptid=="") {
		return;
	}
	
	// Json Obj builder
	JsonObjectBuilder b = Json.createObjectBuilder();
	
	// Connect to db and fetch data
	CachedRowSet crs = new OracleCachedRowSet();
	crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
	crs.setUsername("hr");
	crs.setPassword("hr");
	crs.setCommand("select department_name, manager_id, location_id from departments where manager_id=?");
	crs.setString(1, deptid);
	crs.execute();
	
	// show error if no rows
	if (crs.size()==0){
		b.add("error", "Department_id Not Found");	
	}
	// add data to json
	else{
		if(crs.next()){
			b.add("department_name",crs.getString(1));
			b.add("manager_id",crs.getString(2));
			b.add("location_id",crs.getString(3));
		}
	}
	
	//write json to response
	out.println(b.build().toString());
	crs.close();
%>