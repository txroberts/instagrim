<%-- 
    Document   : Profile
    Created on : 10-Oct-2014, 17:07:40
    Author     : Tom
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.LoggedIn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
    </head>
    <body>
        <%
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            if (lg != null) {
                String UserName = lg.getUsername();
                if (lg.getlogedin()) {
        %>
        <h2><%=lg.getUsername()%>'s Profile</h2>
        <%}
            }else{%>
        <h1>No profile found</h1>
            <%}%>
    </body>
</html>
