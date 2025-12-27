package com.assignment2.profileDAO;

import com.assignment2.bean.ProfileBeans;
import com.profile.util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Profile operations
 * Handles all database CRUD operations
 */
public class profileDAO {
    
    /**
     * Insert a new profile into database
     * @param profile
     * @return 
     */
    public boolean insertProfile(ProfileBeans profile) {
        String sql = "INSERT INTO profile (student_id, name, email, programme, hobby, bio) VALUES (?, ?, ?, ?, ?, ?)";
    
    try (Connection conn = DatabaseUtil.getConnection();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        
        pstmt.setString(1, profile.getStudentId());
        pstmt.setString(2, profile.getName());
        pstmt.setString(3, profile.getEmail());
        pstmt.setString(4, profile.getProgramme());
        pstmt.setString(5, profile.getHobby());
        pstmt.setString(6, profile.getBio());
        
        int rowsAffected = pstmt.executeUpdate();
        System.out.println("✓ Profile inserted! Rows affected: " + rowsAffected);
        return rowsAffected > 0;
        
    } catch (SQLException e) {
        System.err.println("✗ Error inserting profile: " + e.getMessage());
        e.printStackTrace();
        return false;
    }

    }
    
    /**
     * Retrieve all profiles from database
     * @return 
     */
    public List<ProfileBeans> getAllProfiles() {
        List<ProfileBeans> profiles = new ArrayList<>();
        String sql = "SELECT * FROM profile ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                ProfileBeans profile = extractProfileFromResultSet(rs);
                profiles.add(profile);
            }
            
        } catch (SQLException e) {
            System.err.println("Error retrieving profiles: " + e.getMessage());
        }
        
        return profiles;
    }
    
    /**
     * Search profiles by name or student ID
     * @param keyword
     * @return 
     */
    public List<ProfileBeans> searchProfiles(String keyword) {
        List<ProfileBeans> profiles = new ArrayList<>();
        String sql = "SELECT * FROM profile WHERE name LIKE ? OR student_id LIKE ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + keyword + "%";
            pstmt.setString(1, searchPattern);
            pstmt.setString(2, searchPattern);
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProfileBeans profile = extractProfileFromResultSet(rs);
                    profiles.add(profile);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error searching profiles: " + e.getMessage());
        }
        
        return profiles;
    }
    
    /**
     * Get profile by ID
     * @param id
     * @return 
     */
    public ProfileBeans getProfileById(int id) {
        String sql = "SELECT * FROM profile WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    ProfileBeans profile = extractProfileFromResultSet(rs);
                    rs.close();
                    return profile;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting profile: " + e.getMessage());
        }
        
        return null;
    }
    
    /**
     * Update profile details
     * @param profile
     * @return 
     */
    public boolean updateProfile(ProfileBeans profile) {
        String sql = "UPDATE profile SET name=?, email=?, programme=?, hobby=?, bio=? WHERE id=?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, profile.getName());
            pstmt.setString(2, profile.getEmail());
            pstmt.setString(3, profile.getProgramme());
            pstmt.setString(4, profile.getHobby());
            pstmt.setString(5, profile.getBio());
            pstmt.setInt(6, profile.getId());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating profile: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Delete profile by ID
     * @param id
     * @return 
     */
    public boolean deleteProfile(int id) {
        String sql = "DELETE FROM profile WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            System.err.println("Error deleting profile: " + e.getMessage());
            return false;
        }
    }
    
    /**
     * Filter profiles by program
     * @param programme
     * @return 
     */
    public List<ProfileBeans> filterByProgramme(String programme) {
        List<ProfileBeans> profiles = new ArrayList<>();
        String sql = "SELECT * FROM profile WHERE programme LIKE ? ORDER BY created_at DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + programme + "%");
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ProfileBeans profile = extractProfileFromResultSet(rs);
                    profiles.add(profile);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error filtering profiles: " + e.getMessage());
        }
        
        return profiles;
    }
    
    /**
     * Extract ProfileBean object from ResultSet
     */
    private ProfileBeans extractProfileFromResultSet(ResultSet rs) throws SQLException {
        ProfileBeans profile = new ProfileBeans();
        profile.setId(rs.getInt("id"));
        profile.setStudentId(rs.getString("student_id"));
        profile.setName(rs.getString("name"));
        profile.setEmail(rs.getString("email"));
        profile.setProgramme(rs.getString("programme"));
        profile.setHobby(rs.getString("hobby"));
        profile.setBio(rs.getString("bio"));
        profile.setCreatedAt(rs.getTimestamp("created_at"));
        profile.setUpdatedAt(rs.getTimestamp("updated_at"));
        return profile;
    }
}