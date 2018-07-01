package tags;

import java.io.IOException;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import oracle.jdbc.rowset.OracleCachedRowSet;

public class DeptHandler  extends SimpleTagSupport {

	@Override
	public void doTag() throws JspException, IOException {
		
		JspWriter out = getJspContext().getOut();
		
		out.println("<h2>List Of Jobs</h2>");
		out.println("<table border='1'><tr><th>Dept ID</th><th>Dept Name</th><th>Manager name</th></tr>");
		try {
			OracleCachedRowSet crs = new OracleCachedRowSet();
			crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
			crs.setUsername("hr");
			crs.setPassword("hr");
			crs.setCommand("select d.department_id, d.department_name, concat(concat(e.first_name,' '),e.last_name) name from departments d, employees e where d.manager_id=e.manager_id");
			crs.execute();

			while (crs.next()) {
				out.println("<tr><td>" + crs.getString("department_id") + "</td><td>" +
			                 crs.getString("department_name") + "</td><td>"
			                 + crs.getString("name") + "</td>"
			                 		+ "</tr>");
			}
			out.println("</table>");
			crs.close();
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
		 
	}
	
	

}