<HTML>
<HEAD>


<TITLE>Your Login Result</TITLE>
</HEAD>

<BODY>
<!--A simple example to demonstrate how to use JSP to 
    connect and query a database. 
    @author  Hong-Yu Zhang, University of Alberta
 -->
<%@ page import="java.sql.*" %>
<% 

        if(request.getParameter("bSubmit") != null)
        {

	        //get the user input from the login page
        	String userName = (request.getParameter("USERID")).trim();
	        String passwd = (request.getParameter("PASSWD")).trim();
        	out.println("<p>Your input User Name is "+userName+"</p>");
        	out.println("<p>Your input password is "+passwd+"</p>");


	        //establish the connection to the underlying database
        	Connection conn = null;
	
	        String driverName = "oracle.jdbc.driver.OracleDriver";
           	String dbstring="jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
	

		        //load and register the driver
out.println("dname: "+driverName);
out.println("dbstring: "+dbstring);
        		Class drvClass = Class.forName(driverName); 
	        	DriverManager.registerDriver((Driver) drvClass.newInstance());

	

	        	//establish the connection 
		        conn = DriverManager.getConnection(dbstring,"btrinh","trinh187");
                out.println("ga");
        		conn.setAutoCommit(false);
	        
	

	        //select the user table from the underlying db and validate the user name and password
        	Statement stmt = null;
	        ResultSet rset = null;
        	String sql = "select PWD from login where id = '"+userName+"'";
	        out.println(sql+" "+passwd);

	        	stmt = conn.createStatement();
		        rset = stmt.executeQuery(sql);

	        String truepwd = "";
	
        	while(rset != null && rset.next())
	        	truepwd = (rset.getString(1)).trim();
	
        	//display the result
	        if(passwd.equals(truepwd))
		        out.println("<p><b>Your Login is Successful!</b></p>");
        	else
	        	out.println("<p><b>Either your userName or Your password is inValid!</b></p>");

                        conn.close();

        }
        else
        {
                out.println("<form method=post action=login.jsp>");
                out.println("UserName: <input type=text name=USERID maxlength=20><br>");
                out.println("Password: <input type=password name=PASSWD maxlength=20><br>");
                out.println("<input type=submit name=bSubmit value=Submit>");
                out.println("</form>");
        }      
%>



</BODY>
</HTML>

