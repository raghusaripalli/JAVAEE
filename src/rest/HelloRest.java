package rest;

import java.time.LocalDateTime;

import javax.ws.rs.GET;
import javax.ws.rs.Path;

@Path("/hello")
public class HelloRest {
	
	@GET
	public String getMessage() {
		return "Hello Jersey - RESTful service, Now it is: "+LocalDateTime.now();
	}
	
}
