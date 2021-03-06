/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.models;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashSet;
import java.util.Set;
import uk.ac.dundee.computing.aec.instagrim.lib.AeSimpleSHA1;
import uk.ac.dundee.computing.aec.instagrim.stores.ProfilePage;

/**
 *
 * @author Administrator
 */
public class User {
    Cluster cluster;
    public User(){
        
    }
    
    public boolean RegisterUser(String username, String Password, String firstName, String lastName, String emailAddr){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrimtxr");
        Set<String> emails = new HashSet<>();
        emails.add(emailAddr);
        
        PreparedStatement ps = session.prepare("insert into userprofiles (login,password,first_name,last_name,email) Values(?,?,?,?,?)");
       
        BoundStatement boundStatement = new BoundStatement(ps);
        session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username,EncodedPassword,firstName,lastName,emails));
        //We are assuming this always works.  Also a transaction would be good here !
        
        session.close();
        return true;
    }
    
    public void updateUserInfo(String username, String firstName, String lastName, String email){
        Session session = cluster.connect("instagrimtxr");
        if (email.compareTo("") == 0){
            PreparedStatement ps = session.prepare("update userprofiles set first_name = ?, last_name = ? where login = ?");
            BoundStatement bs = new BoundStatement(ps);
            session.execute(bs.bind(firstName, lastName, username));
            session.close();
        }
        else{
            Set<String> emails = new HashSet<>();
            emails.add(email);
            PreparedStatement ps = session.prepare("update userprofiles set first_name = ?, last_name = ?, email = email + ? where login = ?");
            BoundStatement bs = new BoundStatement(ps);
            session.execute(bs.bind(firstName, lastName, emails, username));
            session.close();
        }
    }
    
    public boolean IsValidUser(String username, String Password){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrimtxr");
        PreparedStatement ps = session.prepare("select password from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        
        session.close();
        
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return false;
        } else {
            for (Row row : rs) {
               
                String StoredPass = row.getString("password");
                if (StoredPass.compareTo(EncodedPassword) == 0)
                    return true;
            }
        }
   
    
    return false;  
    }
       public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
       
    public ProfilePage getUserInfo(String user){
        Session session = cluster.connect("instagrimtxr");
        PreparedStatement ps = session.prepare("select login, first_name, last_name, email, profile_pic from userprofiles where login = ?");
        BoundStatement boundStatement = new BoundStatement(ps);
        ResultSet rs = null;
        rs = session.execute(boundStatement.bind(user));
        session.close();
        
        ProfilePage profile = null;
        
        if (rs.isExhausted()) {
            System.out.println("No profiles returned for user: " + user);
            return null;
        } else {
            for (Row row : rs) {
                profile = new ProfilePage();
                
                String username = row.getString("login");
                String firstName = row.getString("first_name");
                String lastName = row.getString("last_name");
                java.util.UUID profilePic = row.getUUID("profile_pic");
                Set<String> emails = row.getSet("email", String.class);
                
                profile.setUsername(username);
                profile.setFirstName(firstName);
                profile.setLastName(lastName);
                profile.setProfilePic(profilePic);
                profile.setEmails(emails);
            }
        }
        
        
        return profile;
    }
    
    public java.util.LinkedList<ProfilePage> searchUser(String searchField, String searchString){
        java.util.LinkedList<ProfilePage> profilePages = new java.util.LinkedList<>();
        
        Session session = cluster.connect("instagrimtxr");
            
        String query = "select login, first_name, last_name, profile_pic from userprofiles where ";
        
        if (searchField.compareTo("username") == 0){
            query += "login = ?";
        } else if (searchField.compareTo("firstName") == 0){
            query += "first_name = ? ALLOW FILTERING";
        } else if (searchField.compareTo("lastName") == 0){
            query += "last_name = ? ALLOW FILTERING";
        } else {
            System.out.println(searchField + " is not a valid search area");
            return null;
        }
        
        System.out.println("Constructed query = " + query + " ---- parameter = " + searchString);
        
        PreparedStatement ps = session.prepare(query);
        BoundStatement boundStatement = new BoundStatement(ps);
        ResultSet rs = null;
        rs = session.execute(boundStatement.bind(searchString));
        session.close();
        
        if (rs.isExhausted()) {
            System.out.println("No profiles returned for: " + searchString);
            return null;
        } else {
            for (Row row : rs) {
                ProfilePage profile = new ProfilePage();
                
                String login = row.getString("login");
                String firstName = row.getString("first_name");
                String lastName = row.getString("last_name");
                java.util.UUID profilePic = row.getUUID("profile_pic");
                
                profile.setUsername(login);
                profile.setFirstName(firstName);
                profile.setLastName(lastName);
                profile.setProfilePic(profilePic);
                
                profilePages.add(profile);
            }
        }
        
        return profilePages;
    }
    
    public java.util.LinkedList<ProfilePage> getAllProfiles(){
        java.util.LinkedList<ProfilePage> profilePages = new java.util.LinkedList<>();
        Session session = cluster.connect("instagrimtxr");
        
        ResultSet rs = null;
        rs = session.execute("select login, first_name, last_name, profile_pic from userprofiles");
        session.close();
        
        if (rs.isExhausted()) {
            System.out.println("No profiles returned");
            return null;
        } else {
            for (Row row : rs) {
                ProfilePage profile = new ProfilePage();
                
                String login = row.getString("login");
                String firstName = row.getString("first_name");
                String lastName = row.getString("last_name");
                java.util.UUID profilePic = row.getUUID("profile_pic");
                
                profile.setUsername(login);
                profile.setFirstName(firstName);
                profile.setLastName(lastName);
                profile.setProfilePic(profilePic);
                
                profilePages.add(profile);
            }
        }
        
        return profilePages;
    }
    
    public boolean userExists(String username){
        Session session = cluster.connect("instagrimtxr");
        PreparedStatement ps = session.prepare("select login from userprofiles where login = ?");
        BoundStatement boundStatement = new BoundStatement(ps);
        ResultSet rs = null;
        rs = session.execute(boundStatement.bind(username));
        
        session.close();
        if (rs.isExhausted()) {
            return false;
        } else {
            return true;
        }
    }
}