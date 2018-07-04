package jaxws;

import javax.jws.WebMethod;
import javax.jws.WebService;

@WebService
public class Hello {
	
	@WebMethod
	public String getMessage() {
		return "Hello from SOAP Service";
	}
}
