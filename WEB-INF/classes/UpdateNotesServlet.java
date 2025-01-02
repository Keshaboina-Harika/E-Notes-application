
import java.io.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
public class UpdateNotesServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	  try {
		    int id=Integer.parseInt(req.getParameter("id"));
			String title = req.getParameter("title");
			String content = req.getParameter("content");
									
			Notes n = new Notes();
			n.setId(id);
			n.setTitle(title);
			n.setContent(content);
						
			NotesDAO dao = new NotesDAO();
			boolean f=dao.updateNotes(n);
			
			HttpSession session=req.getSession();
			
			if(f) {
				resp.sendRedirect("editNotes.jsp?msg=succMsg&id="+id);
				
			}else {
				resp.sendRedirect("editNotes.jsp?id && msg=failedMsg&id="+id);
			}		
	} catch (Exception e) {
		e.printStackTrace();
	}	
	}
}
