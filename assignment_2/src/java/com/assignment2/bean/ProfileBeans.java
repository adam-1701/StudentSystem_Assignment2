package com.assignment2.bean;

import java.io.Serializable;
import java.sql.Timestamp;

/**
 * JavaBean class to represent profile data
 * Contains private attributes with public getters and setters
 */
public class ProfileBeans implements Serializable {
    private static final long serialVersionUID = 1L;
    
    // Private attributes matching your form fields
    private int id;
    private String studentId;
    private String name;
    private String email;
    private String programme;
    private String hobby;
    private String bio;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Default constructor
    public ProfileBeans() {
    }
    
    // Parameterized constructor
    public ProfileBeans(String studentId, String name, String email, 
                      String programme, String hobby, String bio) {
        this.studentId = studentId;
        this.name = name;
        this.email = email;
        this.programme = programme;
        this.hobby = hobby;
        this.bio = bio;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getStudentId() {
        return studentId;
    }
    
    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getProgramme() {
        return programme;
    }
    
    public void setProgramme(String programme) {
        this.programme = programme;
    }
    
    public String getHobby() {
        return hobby;
    }
    
    public void setHobby(String hobby) {
        this.hobby = hobby;
    }
    
    public String getBio() {
        return bio;
    }
    
    public void setBio(String bio) {
        this.bio = bio;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    @Override
    public String toString() {
        return "ProfileBean{" +
                "id=" + id +
                ", studentId='" + studentId + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", programme='" + programme + '\'' +
                ", hobby='" + hobby + '\'' +
                ", bio='" + bio + '\'' +
                '}';
    }
}