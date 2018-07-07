package jsf;


import java.time.LocalDateTime;
import javax.faces.bean.ManagedBean;

@ManagedBean
public class HelloBean {
	public String getMessage() {
		return "Now the time is: "+LocalDateTime.now().toString();
	}
}
