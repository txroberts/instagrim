<%-- 
    Document   : searchProfiles
    Created on : 24-Oct-2014, 17:58:05
    Author     : Tom
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<%@page import="java.util.Iterator"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.ProfilePage"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="Styles.css"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Profiles</title>
    </head>
    <body>
        <header>
            <ul>
                <li class="header"><a href="/Instagrimtxr">Home</a></li>
            </ul>
        </header>
        
        <nav>
            <ul>
                <li><a href="upload.jsp">Upload</a></li>
                <li><a href="searchProfiles.jsp">Search Profiles</a></li>
                    <%
                        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                        if (lg != null) {
                            if (lg.getlogedin()) {
                    %>
                <li><a href="/Instagrimtxr/Profile/<%=lg.getUsername()%>">Your Profile</a></li>
                <li><a href="/Instagrimtxr/Images/<%=lg.getUsername()%>">Your Images</a></li>
                <%}}%>
            </ul>
        </nav>
        
        <br>
        <form method="POST"  action="searchProfiles">
            <fieldset>
                <legend><h3>Search for a user</h3></legend>
                <h3>Search by:</h3>
                <input type="radio" name="searchArea" value="username" checked="checked">Username
                <input type="radio" name="searchArea" value="firstName" disabled="true">First Name
                <input type="radio" name="searchArea" value="lastName" disabled="true">Last Name

                <p><b>Search:</b> <input type="search" name="search" autofocus></p>

                <br/>
                <input type="submit" value="Search">
            </fieldset>
        </form>
        
        <%
            java.util.LinkedList<ProfilePage> profilePages = (java.util.LinkedList<ProfilePage>) request.getAttribute("ProfilePages");
            if (profilePages == null){%>
                <p>No profiles found</p>
            <%}
            else {
                Iterator<ProfilePage> iterator;
                iterator = profilePages.iterator();%>
                <table border="1">
                <%while (iterator.hasNext()){
                    ProfilePage pp = (ProfilePage) iterator.next();
                    if (pp.getProfilePic() == null){ %>
                    <tr><td><a href="/Instagrimtxr/Profile/<%=pp.getUsername()%>"><img src="http://www.genengnews.com/app_themes/genconnect/images/default_profile.jpg"></a></td>
                    <% } else { %>
                    <td><a href="/Instagrimtxr/Profile/<%=pp.getUsername()%>"><img src="/Instagrimtxr/Thumb/<%=pp.getProfilePic()%>"></a></td>
                    <% } %>
                    <td>
                        <h3><a href="/Instagrimtxr/Profile/<%=pp.getUsername()%>"><%=pp.getUsername()%></a></h3>
                        <h5><%=pp.getFirstName()%> <%=pp.getLastName()%></h5>
                    </td>
                    </tr>
                    <%}%>
                </table>
            <%}
        %>
    </body>
</html>
