package rest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.json.Json;
import javax.json.JsonArrayBuilder;
import javax.json.JsonObjectBuilder;
import javax.sql.rowset.CachedRowSet;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.InternalServerErrorException;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.core.MediaType;

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
	
	@POST
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public void addJob(@FormParam("id") String id, @FormParam("title") String title) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement ps = con.prepareStatement("insert into jobs (job_id, job_title) values (?,?)");
			ps.setString(1, id);
			ps.setString(2, title);
			ps.executeUpdate();
		}
		catch(Exception e) {
			throw new InternalServerErrorException();
		}
	}
	
	@PUT
	@Path("/{id}")
	@Consumes(MediaType.APPLICATION_FORM_URLENCODED)
	public void updateJob(@PathParam("id") String id, @FormParam("title") String title) {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement ps = con.prepareStatement("update jobs set job_title=? where job_id=?");
			ps.setString(1, title);
			ps.setString(2, id);
			ps.executeUpdate();
		}
		catch(Exception e) {
			throw new InternalServerErrorException();
		}
	}
	
	@DELETE
	@Path("/{id}")
	public void deleteJob(@PathParam("id") String id) throws ClassNotFoundException {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement ps = con.prepareStatement("delete from jobs where job_id=?");
			ps.setString(1, id);
			if(ps.executeUpdate()!=1) {
				throw new NotFoundException();
			}
		}
		catch(SQLException e) {
			throw new InternalServerErrorException();
		}
	}
}
