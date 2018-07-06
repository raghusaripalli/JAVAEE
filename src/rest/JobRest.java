package rest;

import java.sql.SQLException;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.sql.rowset.CachedRowSet;
import javax.ws.rs.GET;
import javax.ws.rs.InternalServerErrorException;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

import oracle.jdbc.rowset.OracleCachedRowSet;

@Path("/jobs")
public class JobRest {
	
	@GET
	public String getJobs() {
		try {
			CachedRowSet crs = new OracleCachedRowSet();
			crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
			crs.setUsername("hr");
			crs.setPassword("hr");
			crs.setCommand("select job_id, job_title from jobs");
			crs.execute();
			JsonArrayBuilder a = Json.createArrayBuilder();
			while(crs.next()) {
				JsonObjectBuilder b = Json.createObjectBuilder();
				b.add("id", crs.getString("job_id"));
				b.add("title", crs.getString("job_title"));
				a.add(b.build());
			}
			crs.close();
			return a.build().toString();
		}
		catch(Exception e) {
			throw new InternalServerErrorException();
		}
	}
	
	@GET
	@Path("/{id}")
	public String getJob(@PathParam("id") String id) {
		try {
			CachedRowSet crs = new OracleCachedRowSet();
			crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
			crs.setUsername("hr");
			crs.setPassword("hr");
			crs.setCommand("select job_id, job_title from jobs where job_id = ?");
			crs.setString(1, id);
			crs.execute();
			
			if(crs.next()) {
				JsonObjectBuilder b = Json.createObjectBuilder();
				b.add("id", crs.getString("job_id"));
				b.add("title", crs.getString("job_title"));
				crs.close();
				return b.build().toString();
			}
			else {
				crs.close();
				throw new NotFoundException();
			}
		}
		catch(SQLException e) {
			throw new InternalServerErrorException();
		}
	}
}
