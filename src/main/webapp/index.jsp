<%-- 
    Document   : index
    Created on : Sep 28, 2014, 7:01:44 PM
    Author     : Administrator
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <header>
            <ul>
                <li class="header"><a href="/Instagrim">Home</a></li>
            </ul>
            
            <h1>InstaGrim!</h1>
            <%
                LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                if (lg != null) {
                    String UserName = lg.getUsername();
                    if (lg.getlogedin()) {
            %>
            <h2><%=lg.getUsername()%>'s world in black and white!</h2>
            <%}
                }else{%>
            <h2>Your world in black and white!</h2>
                <%}%>
        </header>
        <nav>
            <ul>
                <li><a href="upload.jsp">Upload</a></li>
                    <%
                        lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            String UserName = lg.getUsername();
                            if (lg.getlogedin()) {
                    %>
                <li><a href="/Instagrim/Profile/<%=lg.getUsername()%>">Your Profile</a></li>
                <li><a href="/Instagrim/Images/<%=lg.getUsername()%>">Your Images</a></li>
                <form method="POST"  action="Logout">
                    <input type="submit" value="Logout"> 
                </form>
                    <%}
                            }else{
                                %>
                <li><a href="register.jsp">Register</a></li>
                <li><a href="login.jsp">Login</a></li>
                <%}%>
            </ul>
        </nav>
        <footer>
            <ul>
                <li class="footer">&COPY; Tom Roberts</li>
            </ul>
        </footer>
    </body>
</html>
