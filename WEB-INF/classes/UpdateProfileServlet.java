import java.io.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
public class UpdateProfileServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	  try {
		    int id=Integer.parseInt(req.getParameter("id"));
			String fullName = req.getParameter("fullName");
			String about = req.getParameter("about");
			String ContactNo = req.getParameter("ContactNo");
						
			UserDtls u = new UserDtls();
			u.setId(id);
			u.setFullName(fullName);
			u.setAbout(about);
			u.setContactNo(ContactNo);
			
			UserDAO dao = new UserDAO();
			boolean f=dao.updateUserProfile(u);
			
			HttpSession session=req.getSession();
			
			if(f) {
				session.setAttribute("succMsg", "Profile Updated Successfully..");
				resp.sendRedirect("profile.jsp");
			}else {
				session.setAttribute("failedMsg", "Something wrong on server..!!!");
				resp.sendRedirect("profile.jsp");
			}		
	} catch (Exception e) {
		e.printStackTrace();
	}	
	}
}
