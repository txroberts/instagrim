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
        
        <article>
            <h3>Edit your profile</h3>
            <form method="POST"  action="UpdateProfile">
                <fieldset>
                    <legend>Personal information:</legend>
                    <p><b>User Name:</b> <input type="text" name="username" value="<%=profilePage.getUsername()%>" readonly="readonly" autofocus></p>
                    <p><b>First Name:</b> <input type="text" name="firstName" value="<%=profilePage.getFirstName()%>"></p>
                    <p><b>Last Name:</b> <input type="text" name="lastName" value="<%=profilePage.getLastName()%>"></p>
                    <p><b>Email:</b> <input type="email" name="email" value="tom@email.com"></p>
                    
                    <br/>
                    <input type="submit" value="Update">
                </fieldset>
            </form>
        </article>
    </body>
</html>
