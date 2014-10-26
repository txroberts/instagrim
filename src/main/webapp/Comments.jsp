<%-- 
    Document   : Comments
    Created on : 26-Oct-2014, 15:32:39
    Author     : Tom
--%>

<%@page import="java.util.Iterator"%>
<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.Pic"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Instagrim</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <header>
            <ul>
                <li class="header"><a href="/Instagrim">Home</a></li>
            </ul>
            
            <h1>InstaGrim!</h1>
        </header>
        
        <%
            Pic pic = (Pic) request.getAttribute("Pic");
            
            if (pic == null){ %>
                <p>Picture not found</p>
            <% } else { %>
                <a href="/Instagrim/Image/<%=pic.getSUUID()%>" ><img src="/Instagrim/Thumb/<%=pic.getSUUID()%>"></a>
            <%
                if (pic.getComments().isEmpty()){ %>
                    <p>No comments found</p>
            <%} else { %>
                <h3>Comments</h3>
                    <table border="1">
                        <% java.util.List<String> comments = pic.getComments();
                            Iterator<String> iterator = comments.iterator();
                            while (iterator.hasNext()){ %>
                            <tr><td>
                                <%=iterator.next()%>
                            </td></tr>
                            <% } %>
                    </table>
                <% } 
            }
            %>
    </body>
</html>
