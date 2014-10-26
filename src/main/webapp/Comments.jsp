<%-- 
    Document   : Comments
    Created on : 26-Oct-2014, 15:32:39
    Author     : Tom
--%>

<%@page import="uk.ac.dundee.computing.aec.instagrim.stores.Comment"%>
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
                <li class="header"><a href="/Instagrimtxr">Home</a></li>
            </ul>
            
            <h1>InstaGrim!</h1>
        </header>
        <% String picID = (String) request.getAttribute("picID"); %>
        
        <a href="/Instagrimtxr/Image/<%=picID%>" ><img src="/Instagrimtxr/Thumb/<%=picID%>"></a>
        
        <%
            java.util.LinkedList<Comment> comments = (java.util.LinkedList<Comment>) request.getAttribute("Comments");
            if (comments == null){ %>
            <p>No comments found</p>
            <% } else { %>
                <h3>Comments</h3>
                    <% Iterator<Comment> iterator = comments.iterator();
                        while (iterator.hasNext()){
                            Comment comment = iterator.next();
                        %><table border="1"><tr>
                            <td><%=comment.getUser()%></td>
                            <td><%=comment.getDateCreated()%></td>
                        </tr>
                        <tr>
                            <td colspan="2"><%=comment.getContent()%></td>
                        </tr></table><br>
                        <% } %>
                </table>

                <br>
                <% }
                %>
                
            <form method="POST" action="newComment">
                <input type="hidden" name="picID" value="<%=picID.toString()%>">
                <p><input type="text" name="comment"></p>
                <p><input type="submit" value="Add Comment"></p>
            </form>
            
    </body>
</html>
