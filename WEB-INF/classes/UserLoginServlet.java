import java.io.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;


public class UserLoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("email");
		String pass = req.getParameter("password");
		
		UserDAO dao = new UserDAO();
		UserDtls u = dao.loginUser(email, pass);
		
		HttpSession session = req.getSession();
		if(u!=null) {
			session.setAttribute("email", email);
			session.setAttribute("userId", u.getId());
			session.setAttribute("validMsg", "Successfully Login...");
			resp.sendRedirect("login.jsp");			
		}
		else {
			session.setAttribute("invalidMsg", "Invalid Email & Password");
			resp.sendRedirect("login.jsp");			
		}
	}

}