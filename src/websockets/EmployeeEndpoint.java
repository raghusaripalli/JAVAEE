package websockets;

import javax.json.Json;
import javax.json.JsonObjectBuilder;
import javax.sql.rowset.CachedRowSet;
import javax.websocket.OnMessage;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import oracle.jdbc.rowset.OracleCachedRowSet;

@ServerEndpoint("/emp_details")
public class EmployeeEndpoint {
	
	@OnMessage
	public void getMessage(final Session session, String message) {
		try {
			CachedRowSet crs = new OracleCachedRowSet();
			crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
			crs.setUsername("hr");
			crs.setPassword("hr");
			crs.setCommand("select first_name||' '||last_name name, salary, to_char(hire_date,'dd-MON-yy') hdate from employees where employee_id=?");
			crs.setInt(1, Integer.parseInt(message));
			crs.execute();
			JsonObjectBuilder b = Json.createObjectBuilder();
			while(crs.next()) {
				b.add("name", crs.getString("name"));
				b.add("salary", crs.getString("salary"));
				b.add("hiredate", crs.getString("hdate"));
			}
			session.getBasicRemote().sendText(b.build().toString());
			crs.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
}
