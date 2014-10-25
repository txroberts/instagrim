<%-- 
    Document   : Profile
    Created on : 10-Oct-2014, 17:07:40
    Author     : Tom
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <body>
        <% ProfilePage profilePage = (ProfilePage) request.getAttribute("ProfilePage");
           LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn"); %>
           
        <header>
            <ul>
                <li class="header"><a href="/Instagrim">Home</a></li>
            </ul>
        </header>
           
        <h1>InstaGrim!</h1>
        <h2>Your world in Black and White</h2>
        <nav>
            <ul>
                <li class="nav"><a href="/Instagrim/upload.jsp">Upload</a></li>
                <% if (lg != null && lg.getlogedin()) {
                    if (profilePage.getUsername().compareTo(lg.getUsername()) == 0){ %>
                        <li><a href="/Instagrim/Images/<%=profilePage.getUsername()%>">Your Images</a></li>
                <%  } else { %>
                    <li><a href="/Instagrim/Images/<%=profilePage.getUsername()%>"><%=profilePage.getUsername()%>'s Images</a></li>
                    <% }} %>
            </ul>
        </nav>
        
        <% if (profilePage == null){ %>
                <h2>User profile not found</h2>
            <% }
            else { %>
                <h2><%=profilePage.getUsername()%>'s Profile</h2>
                <% if (profilePage.getFirstName() !=  null && profilePage.getLastName() != null){ %>
                    <p><b>Real name:</b> <%=profilePage.getFirstName()%> <%=profilePage.getLastName()%></p>
                <%}%>
                
                <% if (profilePage.getProfilePic() == null){ %>
                    <img height="150" width="150" src="http://www.genengnews.com/app_themes/genconnect/images/default_profile.jpg">
                <% } else { %>
                    <a href="/Instagrim/Image/<%=profilePage.getProfilePic()%>" ><img src="/Instagrim/Thumb/<%=profilePage.getProfilePic()%>"></a>
                <% } %>
            
            <% if (lg != null && lg.getlogedin()){
                    if (profilePage.getUsername().compareTo(lg.getUsername()) == 0){ %>
            <article>
                <h3>Upload Profile Picture</h3>
                <form method="POST" enctype="multipart/form-data" action="Profile">
                    File to upload: <input type="file" name="upfile"><br/>

                    <br/>
                    <input type="submit" value="Press"> to upload the file!
                </form>
                
                <p><a href="/Instagrim/editProfile/<%=profilePage.getUsername()%>">Edit your profile information</a></p>
            </article>
            <% }}} %>
    </body>
</html>