<%-- 
    Document   : Profile
    Created on : 10-Oct-2014, 17:07:40
    Author     : Tom
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.ProfilePage"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
        <link rel="stylesheet" type="text/css" href="Styles.css" />
    </head>
    <body>
        <h1>InstaGrim!</h1>
        <h2>Your world in Black and White</h2>
        <nav>
            <ul>
                <li class="nav"><a href="upload.jsp">Upload</a></li>
                <li class="nav"><a href="/Instagrim/Images/majed">Sample Images</a></li>
            </ul>
            <form method="POST"  action="Logout">
                    <input type="submit" value="Logout"> 
                </form>
        </nav>
        
        <%
            ProfilePage profilePage = (ProfilePage) request.getAttribute("ProfilePage");
            if (profilePage == null){ %>
                <h2>User not found</h2>
            <% }
            else { 
                if (profilePage.getProfilePic() != null){%>
                    <h2><%=profilePage.getUsername()%>'s Profile Page</h2>
                    <h4><%=profilePage.getFirstName()%> <%=profilePage.getLastName()%></h4>
                    <a href="/Instagrim/Image/<%=profilePage.getProfilePic()%>" ><img src="/Instagrim/Thumb/<%=profilePage.getProfilePic()%>"></a>
            <% }}
        %>
        
        <article>
            <h3>Upload Profile Picture</h3>
            <form method="POST" enctype="multipart/form-data" action="UploadProfilePic">
                File to upload: <input type="file" name="upfile"><br/>

                <br/>
                <input type="submit" value="Press"> to upload the file!
            </form>

        </article>
            
        <footer>
            <ul>
                <li class="footer"><a href="/Instagrim">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
