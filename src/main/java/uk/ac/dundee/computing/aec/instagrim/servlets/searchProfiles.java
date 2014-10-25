/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.models.User;
import uk.ac.dundee.computing.aec.instagrim.stores.ProfilePage;

/**
 *
 * @author Tom
 */
@WebServlet(name = "searchProfiles", urlPatterns = {"/searchProfiles"})
public class searchProfiles extends HttpServlet {
    
    private Cluster cluster;
    
    public searchProfiles(){
        
    }
    
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/searchProfiles.jsp");
        rd.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchArea = request.getParameter("searchArea");
        String searchString = request.getParameter("search");
        
        if (searchString.compareTo("") == 0){
            RequestDispatcher rd = request.getRequestDispatcher("/searchProfiles.jsp");
            rd.forward(request, response);
            
        } else{
            DisplayUserProfiles(searchArea, searchString, request, response);
        }
    }
    
    private void DisplayUserProfiles(String searchField, String searchString, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User us = new User();
        us.setCluster(cluster);
        java.util.LinkedList<ProfilePage> profilePages = us.searchUser(searchField, searchString);
        //java.util.LinkedList<ProfilePage> profilePages = us.searchUser(searchField, "test");
        
        RequestDispatcher rd = request.getRequestDispatcher("/searchProfiles.jsp");
        if (profilePages == null){
            rd.forward(request, response);
        }
        else {
            request.setAttribute("ProfilePages", profilePages);
            System.out.println("Num returned profiles: " + profilePages.size());
            rd.forward(request, response);
        }   
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
