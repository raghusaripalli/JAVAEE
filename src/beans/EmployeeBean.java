package beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class EmployeeBean {
	private int empid, salary;
	
	// empid property
	public int getEmpid() {
		return empid;
	}

	public void setEmpid(int empid) {
		this.empid = empid;
	}
	
	// salary property
	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}
	
	public boolean process() {
		Connection con = null;
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "hr", "hr");
			PreparedStatement ps = con.prepareStatement
					("update employees set salary=? where employee_id=?");
			ps.setInt(1, salary);
			ps.setInt(2, empid);
			int nr = ps.executeUpdate();
			return nr == 1;
		}
		catch(Exception ex) {
			System.out.print(ex.getMessage());
			try {
				con.close();
			}
			catch(Exception e) {}
			return false;
		}
	}
}
