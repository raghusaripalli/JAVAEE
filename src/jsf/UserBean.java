package jsf;

import javax.faces.bean.ManagedBean;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@ManagedBean
public class UserBean {

	private String username, password, message;

	@NotNull(message = "Username is mandatory!")
	@Size(min = 4, max = 10)
	@Pattern (regexp="^\\w+$",  message = "Must be only word chars")
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@NotNull(message = "Password is mandatory!")
	@Size(min = 8, max = 10)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMessage() {
		return message;
	}

	// Action controller
	public String login() {
		if (username.equals("admin") && password.equals("admin"))
			return "home"; // home.xhtml
		else {
			message = "Invalid Login!";
			return "login"; // login.xhtml
		}
	}

	// Action controller
	public String register() {
		return "home"; // home.xhtml
	}
}