<%-- 
    Document   : UsersPics
    Created on : Sep 24, 2014, 2:52:48 PM
    Author     : Administrator
--%>

<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="uk.ac.dundee.computing.aec.instagrim.stores.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Instagrim</title>
        <link rel="stylesheet" type="text/css" href="/Instagrimtxr/Styles.css" />
    </head>
    <body>
        <header>
        
        <h1>InstaGrim! </h1>
        
        </header>
        
        <nav>
            <ul>
                <li class="nav"><a href="/Instagrimtxr/upload.jsp">Upload</a></li>
                <li class="nav"><a href="/Instagrimtxr/Images/majed">Sample Images</a></li>
            </ul>
        </nav>
 
        <article>
            
            <%
                LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
                if (lg != null) {
                    if (lg.getlogedin()) {
            %>
            <h2><%=lg.getUsername()%>'s pics</h2>
            <%}
                }else{%>
            <h1>Your Pics</h1>
                <%}%>
        <%
            java.util.LinkedList<Pic> lsPics = (java.util.LinkedList<Pic>) request.getAttribute("Pics");
            if (lsPics == null) {
        %>
        <p>No Pictures found</p>
        <%
        } else {
            Iterator<Pic> iterator;
            iterator = lsPics.iterator();
            while (iterator.hasNext()) {
                Pic p = (Pic) iterator.next();

        %>
        <a href="/Instagrimtxr/Comments/<%=p.getSUUID()%>" ><img src="/Instagrimtxr/Thumb/<%=p.getSUUID()%>"></a><br/><%

            }
            }
        %>
        </article>
        <footer>
            <ul>
                <li class="footer"><a href="/Instagrimtxr">Home</a></li>
            </ul>
        </footer>
    </body>
</html>
