package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.CachedRowSet;

import oracle.jdbc.rowset.OracleCachedRowSet;

@WebServlet("/names")
public class NameServlet extends HttpServlet {
	ArrayList<String> al = new ArrayList<>();
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		if (name != null)
			this.al.add(name);
		PrintWriter pw = response.getWriter();
		pw.println("<h1> Names </h1>");
		response.setContentType("text/html");
		
		for (String a: al) {
			pw.println("<p>"+a+"</p>");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	public void init() {
		System.out.println("init()");
	}
	
	public void destroy() {
		System.out.println("Destroy()");
	}

}
