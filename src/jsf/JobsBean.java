package jsf;

import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.sql.rowset.CachedRowSet;

import oracle.jdbc.rowset.OracleCachedRowSet;

@ManagedBean
public class JobsBean {
	
	public List<Job> getJob() {
		try {
			CachedRowSet crs = new OracleCachedRowSet();
			crs.setUrl("jdbc:oracle:thin:@localhost:1521:xe");
			crs.setUsername("hr");
			crs.setPassword("hr");
			crs.setCommand("select job_id, job_title from jobs");
			crs.execute();
			
			ArrayList<Job> a = new ArrayList<>();
			while(crs.next()) {
				Job e = new Job();
				e.setId(crs.getString("job_id"));
				e.setTitle(crs.getString("job_title"));
				a.add(e);
			}
			crs.close();
			return a;
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
}
