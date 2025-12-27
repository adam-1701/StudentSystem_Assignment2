package com.assignment2.servlet;

import com.assignment2.bean.ProfileBeans;
import com.assignment2.profileDAO.profileDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Enhanced ProfileServlet with database integration
 * Handles form submission, search, edit, delete, and filter operations
 */
@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private profileDAO profileDAO;
    
    @Override
    public void init() {
        profileDAO = new profileDAO();
        System.out.println("ProfileServlet initialized!");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== doPost called ===");
        String action = request.getParameter("action");
        System.out.println("Action: " + action);
        
        if (action == null || action.isEmpty()) {
            // Default action: add new profile from form submission
            addProfile(request, response);
            return;
        }
        
        switch (action) {
            case "add":
            case "create":
                addProfile(request, response);
                break;
            case "update":
                updateProfile(request, response);
                break;
            case "search":
                searchProfiles(request, response);
                break;
            case "filter":
                filterProfiles(request, response);
                break;
            default:
                addProfile(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("=== doGet called ===");
        String action = request.getParameter("action");
        System.out.println("Action: " + action);
        
        if (action == null || action.isEmpty()) {
            // Default: show all profiles
            viewAllProfiles(request, response);
            return;
        }
        
        switch (action) {
            case "viewAll":
                viewAllProfiles(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteProfile(request, response);
                break;
            default:
                viewAllProfiles(request, response);
        }
    }
    
    /**
     * Add new profile to database
     */
    private void addProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Retrieve form data (matching your index.html field names)
            String name = request.getParameter("name");
            String studentId = request.getParameter("studentId");
            String programme = request.getParameter("program"); // From form: "program"
            String email = request.getParameter("email");
            String hobbies = request.getParameter("hobbies");
            String selfIntro = request.getParameter("selfIntro");
            
            // Debug output
            System.out.println("Form Data Received:");
            System.out.println("Name: " + name);
            System.out.println("Student ID: " + studentId);
            System.out.println("Programme: " + programme);
            System.out.println("Email: " + email);
            System.out.println("Hobbies: " + hobbies);
            System.out.println("Self Intro: " + selfIntro);
            
            // Create ProfileBean object
            ProfileBeans profile = new ProfileBeans();
            profile.setStudentId(studentId);
            profile.setName(name);
            profile.setEmail(email);
            profile.setProgramme(programme);
            profile.setHobby(hobbies);
            profile.setBio(selfIntro);
            
            // Insert into database using JDBC
            boolean success = profileDAO.insertProfile(profile);
            System.out.println("Database insert success: " + success);
            
            if (success) {
                // Set attributes for JSP (matching profile.jsp expectations)
                request.setAttribute("name", name);
                request.setAttribute("studentId", studentId);
                request.setAttribute("program", programme);
                request.setAttribute("email", email);
                request.setAttribute("hobbies", hobbies);
                request.setAttribute("selfIntro", selfIntro);
                request.setAttribute("message", "Profile saved successfully!");
                
                System.out.println("Forwarding to profile.jsp");
                
                // Forward to profile.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("profile.jsp");
                dispatcher.forward(request, response);
            } else {
                System.out.println("Failed to save profile - forwarding to error.jsp");
                request.setAttribute("errorTitle", "Failed to save profile");
                request.setAttribute("errorMessage", "Student ID may already exist or database connection failed.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
                dispatcher.forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("Exception in addProfile: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("errorTitle", "Error");
            request.setAttribute("errorMessage", e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    /**
     * View all profiles
     */
    private void viewAllProfiles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            System.out.println("Fetching all profiles from database...");
            List<ProfileBeans> profiles = profileDAO.getAllProfiles();
            System.out.println("Profiles found: " + profiles.size());
            
            request.setAttribute("profiles", profiles);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("viewProfiles.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in viewAllProfiles: " + e.getMessage());
            e.printStackTrace();
            
            request.setAttribute("errorTitle", "Error loading profiles");
            request.setAttribute("errorMessage", e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
    
    
    /**
     * Search profiles by name or student ID
     */
    private void searchProfiles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String keyword = request.getParameter("keyword");
            System.out.println("Searching profiles with keyword: " + keyword);
            
            List<ProfileBeans> profiles = profileDAO.searchProfiles(keyword);
            System.out.println("Search results: " + profiles.size() + " profiles found");
            
            request.setAttribute("profiles", profiles);
            request.setAttribute("keyword", keyword);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("viewProfiles.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in searchProfiles: " + e.getMessage());
            e.printStackTrace();
            viewAllProfiles(request, response);
        }
    }
    
    /**
     * Filter profiles by program
     */
    private void filterProfiles(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String programme = request.getParameter("programme");
            System.out.println("Filtering profiles by programme: " + programme);
            
            List<ProfileBeans> profiles;
            if (programme == null || programme.isEmpty()) {
                profiles = profileDAO.getAllProfiles();
            } else {
                profiles = profileDAO.filterByProgramme(programme);
            }
            
            System.out.println("Filter results: " + profiles.size() + " profiles found");
            
            request.setAttribute("profiles", profiles);
            request.setAttribute("filterProgramme", programme);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("viewProfiles.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in filterProfiles: " + e.getMessage());
            e.printStackTrace();
            viewAllProfiles(request, response);
        }
    }
    
    /**
     * Show edit form
     */
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println("Loading edit form for profile ID: " + id);
            
            ProfileBeans profile = profileDAO.getProfileById(id);
            
            if (profile != null) {
                request.setAttribute("profile", profile);
                RequestDispatcher dispatcher = request.getRequestDispatcher("editProfile.jsp");
                dispatcher.forward(request, response);
            } else {
                System.out.println("Profile not found with ID: " + id);
                response.sendRedirect("ProfileServlet?action=viewAll");
            }
        } catch (Exception e) {
            System.err.println("Error in showEditForm: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("ProfileServlet?action=viewAll");
        }
    }
    
    /**
     * Update profile
     */
    private void updateProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String programme = request.getParameter("programme");
            String hobby = request.getParameter("hobby");
            String bio = request.getParameter("bio");
            
            System.out.println("Updating profile ID: " + id);
            
            ProfileBeans profile = new ProfileBeans();
            profile.setId(id);
            profile.setName(name);
            profile.setEmail(email);
            profile.setProgramme(programme);
            profile.setHobby(hobby);
            profile.setBio(bio);
            
            boolean success = profileDAO.updateProfile(profile);
            System.out.println("Update success: " + success);
            
            response.sendRedirect("ProfileServlet?action=viewAll");
        } catch (Exception e) {
            System.err.println("Error in updateProfile: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("ProfileServlet?action=viewAll");
        }
    }
    
    /**
     * Delete profile
     */
    private void deleteProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            System.out.println("Deleting profile ID: " + id);
            
            boolean success = profileDAO.deleteProfile(id);
            System.out.println("Delete success: " + success);
            
            response.sendRedirect("ProfileServlet?action=viewAll");
        } catch (Exception e) {
            System.err.println("Error in deleteProfile: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("ProfileServlet?action=viewAll");
        }
    }
    
  
}