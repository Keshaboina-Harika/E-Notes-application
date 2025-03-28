
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>

<%

 class Notes {
	
	private int id;
	private String title;
	private String content;
	private String emailid;
	private String creationDate;
	private String updationDate;
	
	public Notes() {
		super();
	}
	
	public Notes(String title, String content, String emailid) {
		super();
		this.title = title;
		this.content = content;
		this.emailid = emailid;
	}
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getEmailid() {
		return emailid;
	}
	public void setEmailid(String emailid) {
		this.emailid = emailid;
	}
	
	public String getCreationDate() {
		return creationDate;
	}
	public void setCreationDate(String creationDate) {
		this.creationDate = creationDate;
	}
	
	public String getUpdationDate() {
		return updationDate;
	}
	public void setUpdationDate(String updationDate) {
		this.updationDate = updationDate;
	}
	
	@Override
	public String toString() {
		return "Notes [id=" + id + ", title=" + title + ", content=" + content + ", emailid=" + emailid
				+ ", creationDate=" + creationDate + ", updationDate=" + updationDate + "]";
	}	

}


%>
<%

 class NotesDAO {
	
	private Connection con;

	public NotesDAO() {
		super();
	}
	
	//Add Notes 
  	public boolean addNotes(Notes app) {
  		boolean f=false;
  		
  		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/enotes","**","****");
  			String sql="insert into notes(title,content,emailid) values(?,?,?)";
  			PreparedStatement ps=con.prepareStatement(sql);
  			ps.setString(1, app.getTitle());
  			ps.setString(2, app.getContent()); 
  			ps.setString(3, app.getEmailid().trim());
  			
  			int i=ps.executeUpdate();
  			
  			if(i==1) {
  				f=true;
  			}			
  		} catch (Exception e) {
  			e.printStackTrace();
  		}
  		return f;
  	}
  	
  	//View Notes 
  	public List<Notes> getAllNotes(String email) {  		
  		List<Notes> list = new ArrayList<Notes>();
  		Notes b=null;
		
	    try {        
		   Class.forName("com.mysql.cj.jdbc.Driver");
		   Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/enotes","***","*****");
		   String sql="select * from notes where emailid='"+email+"'";
		   PreparedStatement ps = con.prepareStatement(sql);
		   ResultSet rs = ps.executeQuery();
		   
		   while(rs.next()) {
			   
			b=new Notes();
			b.setId(rs.getInt(1));
			b.setTitle(rs.getString(2));
			b.setContent(rs.getString(3));
			b.setEmailid(rs.getString(4));			
			b.setCreationDate(rs.getString(5));
			list.add(b);			
		   }		   
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return list;
  	}
  	
  	// Update Notes
 	public boolean updateNotes(Notes n) {
 		boolean f = false;
 		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/enotes","***","*****");
 			String sql = "update notes set title=?, content=? where id=?";
 			PreparedStatement ps = con.prepareStatement(sql);
 			ps.setString(1, n.getTitle());
 			ps.setString(2, n.getContent());
 			ps.setInt(3, n.getId());

 			int i = ps.executeUpdate();
 			if (i == 1) {
 				f = true;
 			}
 		} catch (Exception e) {
 			e.printStackTrace();
 		}
 		return f;
 	}
 	public boolean deleteNotes(Notes n) {
 		boolean f = false;
 		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/enotes","***"","*****");
 			String sql = "DELETE FROM notes WHERE id = ?";
 			PreparedStatement ps = con.prepareStatement(sql);
 			ps.setInt(1, n.getId());
           
 			int i = ps.executeUpdate();
 			if (i == 1) {
 				f = true;
 			}
 		} catch (Exception e) {
 			e.printStackTrace();
 		}
 		return f;
 	}

}


%>
<%
	String email = session.getAttribute("email").toString().trim();
    int uid;
    String fullName = "";
    String about = "";
	String ContactNo = "";	
	String role ="";
	String RegDate = "";
	
	
	try {
		Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/enotes","***","****");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery("select * from userdtls where email='" + email + "'");
		if (rs.next()) {
			uid=rs.getInt(1);
			fullName = rs.getString(2);
			about = rs.getString(3);
			ContactNo = rs.getString(4);
			role = rs.getString(7);
			RegDate = rs.getString(8);
		}
	} catch (Exception e) {
		System.out.println(e);
	}
%>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">

  <title>Enotes Management System</title>
  <meta content="" name="description">
  <meta content="" name="keywords">

  <!-- Favicons -->
  <link href="assets/img/favicon.png" rel="icon">
  <link href="assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Google Fonts -->
  <link href="https://fonts.gstatic.com" rel="preconnect">
  <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
  <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
  <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
  <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

  <!-- Template Main CSS File -->
  <link href="assets/css/style.css" rel="stylesheet">

</head>

<body>

  <!-- ======= Header ======= -->
  <header id="header" class="header fixed-top d-flex align-items-center">

    <div class="d-flex align-items-center justify-content-between">
      <a href="index.jsp" class="logo d-flex align-items-center">
        <img src="images/enotes.jpg" alt="">
      </a>
      
    </div><!-- End Logo -->

    <nav class="header-nav ms-auto">
      <ul class="d-flex align-items-center">


        <li class="nav-item pe-3">

          
            <span class="d-none d-md-block  ps-2"><% out.println("Hello "+fullName);%></span>
          

          <!-- End Profile Dropdown Items -->
        </li><!-- End Profile Nav -->

      </ul>
    </nav><!-- End Icons Navigation -->

  </header><!-- End Header -->

  <!-- ======= Sidebar ======= -->
  <aside id="sidebar" class="sidebar">

    <ul class="sidebar-nav" id="sidebar-nav">

      <li class="nav-item">
        <a class="nav-link collapsed" href="dashboard.jsp">
          <i class="bi bi-grid"></i>
          <span>Dashboard</span>
        </a>
      </li><!-- End Dashboard Nav -->


      <li class="nav-item">
        <a class="nav-link collapsed" href="profile.jsp">
          <i class="bi bi-person"></i>
          <span>Profile</span>
        </a>
      </li><!-- End Profile Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="addNotes.jsp">
          <i class="bi bi-question-circle"></i>
          <span>Add Notes</span>
        </a>
      </li><!-- End F.A.Q Page Nav -->

      <li class="nav-item">
        <a class="nav-link " href="viewNotes.jsp">
          <i class="bi bi-envelope"></i>
          <span>View Notes</span>
        </a>
      </li><!-- End Contact Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="changePassword.jsp">
          <i class="bi bi-card-list"></i>
          <span>Change Password</span>
        </a>
      </li><!-- End Register Page Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="logout">
          <i class="bi bi-box-arrow-in-right"></i>
          <span>Logout</span>
        </a>
      </li><!-- End Login Page Nav -->
    </ul>

  </aside><!-- End Sidebar-->

  <main id="main" class="main">

<div class="pagetitle">
		<h1>View Notes</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="/dashboard">Home</a></li>
				<li class="breadcrumb-item active">View Notes</li>
			</ol>
		</nav>
	</div>

	<section class="section">
		<div class="row">
			<div class="col-lg-12">

				<div class="card">
					<div class="card-body">
						<h5 class="card-title">View Notes</h5>

						<!-- Table with stripped rows -->
						<table class="table table-striped">
							<thead>
								<tr>
									<th scope="col">#</th>
									<th scope="col">Title</th>
									<th scope="col">Creation Date</th>
									<th scope="col">Action</th>
								</tr>
							</thead>

							<tbody>
								<%
									NotesDAO dao = new NotesDAO();
									List<Notes> list = dao.getAllNotes(email);
									int i=0;
									for (Notes n : list) {
										i++;
								%>
								<tr>
									<td><%=i%></td>
									<td><%=n.getTitle() %></td>
									<td><%=n.getCreationDate() %></td>
									<td><a href="editNotes.jsp?id=<%=n.getId()%>"
										class="btn btn-primary">Edit</a> | <a
										href="deleteNotes?id=<%=n.getId()%>" class="btn btn-danger"
										onclick="return confirm('Are your sure to Delete ?')">Delete</a></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>

			</div>
		</div>
	</section>

  </main><!-- End #main -->
  
  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">
    <div class="copyright">
      &copy; Copyright <strong><span>Enotes Management System</span></strong>.
    </div>
  </footer><!-- End Footer -->

  <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Vendor JS Files -->
  <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
  <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="assets/vendor/chart.js/chart.min.js"></script>
  <script src="assets/vendor/echarts/echarts.min.js"></script>
  <script src="assets/vendor/quill/quill.min.js"></script>
  <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  <script src="assets/vendor/tinymce/tinymce.min.js"></script>
  <script src="assets/vendor/php-email-form/validate.js"></script>

  <!-- Template Main JS File -->
  <script src="assets/js/main.js"></script>

</body>
</html>
