package jsf;

import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.event.ActionEvent;
import javax.sql.rowset.CachedRowSet;

import oracle.jdbc.rowset.OracleCachedRowSet;

@ManagedBean
public class EmployeesBean {
	private String part;
	private List<Employee> result = null;
	public void getEmployees(ActionEvent ae){
		try {
			CachedRowSet crs = new OracleCachedRowSet();
			crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
			crs.setUsername("hr");
			crs.setPassword("hr");
			String cmd = "select employee_id, first_name||' '||last_name name, salary, to_char(hire_date, 'dd-MON-yy') hiredate from employees where first_name like ? or last_name like ?";
			crs.setCommand(cmd);
			crs.setString(1, "%"+part+"%");
			crs.setString(2, "%"+part+"%");
			crs.execute();
			
			result = new ArrayList<>();
			while(crs.next()) {
				Employee e = new Employee();
				e.setId(crs.getInt("employee_id"));
				e.setSalary(crs.getInt("salary"));
				e.setName(crs.getString("name"));
				e.setHiredate(crs.getString("hiredate"));
				result.add(e);
			}
			crs.close();
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			result = null;
		}
	}
	public String getPart() {
		return part;
	}
	public void setPart(String part) {
		this.part = part;
	}
	public List<Employee> getResult() {
		return result;
	}
	public void setResult(List<Employee> result) {
		this.result = result;
	}
}
