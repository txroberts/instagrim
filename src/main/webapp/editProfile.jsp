<%-- 
    Document   : editProfile
    Created on : 24-Oct-2014, 14:22:07
    Author     : Tom
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit your profile information</title>
    </head>
    <body>
        <% ProfilePage profilePage = (ProfilePage) request.getAttribute("ProfilePage");
           LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn"); %>
        <header>
            <h1>InstaGrim!</h1>
            <h2>Your world in Black and White</h2>
        </header>
        
        <% if (lg != null && profilePage != null && lg.getlogedin()){
            if (profilePage.getUsername().compareTo(lg.getUsername()) == 0){ %>
                <article>
                    <h3>Edit your profile</h3>
                    <form method="POST"  action="UpdateProfile">
                        <ul>
                            <li><b>User Name:</b> <input type="text" name="username" value="<%=profilePage.getUsername()%>" readonly="readonly"></li>
                            <li><b>First Name:</b> <input type="text" name="firstName" value="<%=profilePage.getFirstName()%>"></li>
                            <li><b>Last Name:</b> <input type="text" name="lastName" value="<%=profilePage.getLastName()%>"></li>
                        </ul>
                        <br/>
                        <input type="submit" value="Update"> 
                    </form>
                </article>
        <% } else {
                response.sendRedirect("/Instagrim");
                }
        } else {
            response.sendRedirect("/Instagrim");
        }%>
    </body>
</html>
