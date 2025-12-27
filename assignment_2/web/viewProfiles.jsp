<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.assignment2.bean.ProfileBeans" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Student Profiles</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Poppins", sans-serif;
            min-height: 100vh;
            background: linear-gradient(135deg, #ff9f80, #ffe066, #6a4c93, #ff6f91, #ffb347, #c44569);
            background-size: 1200% 1200%;
            animation: gradientMove 20s ease infinite;
            padding: 30px 20px;
            position: relative;
            overflow-x: hidden;
        }

        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .snow {
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
            z-index: 1;
            overflow: hidden;
        }

        .snowflake {
            position: absolute;
            top: -10px;
            background: white;
            border-radius: 50%;
            opacity: 0.8;
            animation: fall linear infinite;
        }

        @keyframes fall {
            to { transform: translateY(100vh); }
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        .header {
            background: rgba(245, 211, 206, 0.95);
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            border: 3px solid;
            border-image-slice: 1;
            border-image-source: linear-gradient(45deg, #ff9f80, #6a4c93);
        }

        h1 {
            text-align: center;
            color: #381a04;
            margin-bottom: 25px;
            font-size: 32px;
        }

        .search-filter-bar {
            display: flex;
            gap: 15px;
            margin-bottom: 20px;
            flex-wrap: wrap;
        }

        .search-box, .filter-box {
            flex: 1;
            min-width: 250px;
            display: flex;
            gap: 10px;
        }

        .search-box input, .filter-box select {
            flex: 1;
            padding: 12px 15px;
            border: 2px solid #d0874a;
            border-radius: 10px;
            font-size: 15px;
            background: white;
        }

        .btn {
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            font-size: 14px;
        }

        .btn-search {
            background: #3498db;
            color: white;
        }

        .btn-search:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }

        .btn-filter {
            background: #9b59b6;
            color: white;
        }

        .btn-filter:hover {
            background: #8e44ad;
        }

        .btn-primary {
            background: #d0874a;
            color: white;
        }

        .btn-primary:hover {
            background: #b46b2a;
        }

        .btn-actions {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 15px;
        }

        .profiles-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        .profile-card {
            background: rgba(255, 250, 240, 0.95);
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            border-left: 5px solid #d0874a;
            transition: all 0.3s;
            position: relative;
        }

        .profile-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 35px rgba(0,0,0,0.3);
        }

        .profile-header {
            border-bottom: 2px solid #f0e6d2;
            padding-bottom: 15px;
            margin-bottom: 15px;
        }

        .profile-name {
            font-size: 22px;
            font-weight: bold;
            color: #381a04;
            margin-bottom: 5px;
        }

        .profile-id {
            color: #d0874a;
            font-size: 14px;
            font-weight: 600;
        }

        .profile-info {
            margin: 10px 0;
            color: #34495e;
            font-size: 14px;
        }

        .profile-info strong {
            color: #2c3e50;
            display: inline-block;
            min-width: 90px;
        }

        .profile-bio {
            background: #f8f9fa;
            padding: 12px;
            border-radius: 8px;
            margin-top: 12px;
            font-size: 13px;
            color: #555;
            font-style: italic;
            border-left: 3px solid #3498db;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            margin-top: 15px;
        }

        .btn-edit {
            flex: 1;
            background: #27ae60;
            color: white;
            padding: 10px;
            text-align: center;
        }

        .btn-edit:hover {
            background: #229954;
        }

        .btn-delete {
            flex: 1;
            background: #e74c3c;
            color: white;
            padding: 10px;
            text-align: center;
        }

        .btn-delete:hover {
            background: #c0392b;
        }

        .no-profiles {
            background: rgba(255, 250, 240, 0.95);
            padding: 50px;
            text-align: center;
            border-radius: 15px;
            color: #555;
            font-size: 18px;
        }

        .count-badge {
            background: #3498db;
            color: white;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            display: inline-block;
            margin-bottom: 15px;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="snow" id="snow"></div>

    <div class="container">
        <div class="header">
            <h1><i class="fas fa-users"></i> Student Profile Management System</h1>
            
            <!-- Search and Filter Bar -->
            <div class="search-filter-bar">
                <form action="ProfileServlet" method="post" class="search-box">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="keyword" placeholder="🔍 Search by name or student ID..." 
                           value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>">
                    <button type="submit" class="btn btn-search">
                        <i class="fas fa-search"></i> Search
                    </button>
                </form>

              <form action="ProfileServlet" method="post" class="filter-box">
    <input type="hidden" name="action" value="filter">

    <%
        String selectedProgramme = request.getAttribute("selectedProgramme") != null
                ? request.getAttribute("selectedProgramme").toString()
                : "";
    %>

    <select name="programme">
        <option value=""
            <%= selectedProgramme.equals("") ? "selected" : "" %>>
            All Program
        </option>

        <option value="Computer Science"
            <%= selectedProgramme.equals("Computer Science") ? "selected" : "" %>>
            Computer Science
        </option>

        <option value="Information Technology"
            <%= selectedProgramme.equals("Information Technology") ? "selected" : "" %>>
            Information Technology
        </option>

        <option value="Software Engineering"
            <%= selectedProgramme.equals("Software Engineering") ? "selected" : "" %>>
            Software Engineering
        </option>

        <option value="Data Science"
            <%= selectedProgramme.equals("Data Science") ? "selected" : "" %>>
            Data Science
        </option>

        <option value="Cybersecurity"
            <%= selectedProgramme.equals("Cybersecurity") ? "selected" : "" %>>
            Cybersecurity
        </option>
    </select>

    <button type="submit" class="btn btn-filter">
        <i class="fas fa-filter"></i> Filter
    </button>
</form>


                    
                    
            </div>

            <div class="btn-actions">
                <a href="index.html" class="btn btn-primary">
                    <i class="fas fa-plus-circle"></i> Add New Profile
                </a>
                <a href="ProfileServlet?action=viewAll" class="btn btn-primary">
                    <i class="fas fa-sync-alt"></i> Show All Profiles
                </a>
            </div>
        </div>

        <%
            List<ProfileBeans> profiles = (List<ProfileBeans>) request.getAttribute("profiles");
            if (profiles != null && !profiles.isEmpty()) {
        %>
            <div class="count-badge">
                <i class="fas fa-database"></i> Total Profiles: <%= profiles.size() %>
            </div>

            <div class="profiles-grid">
                <%
                    for (ProfileBeans profile : profiles) {
                %>
                    <div class="profile-card">
                        <div class="profile-header">
                            <div class="profile-name">
                                <i class="fas fa-user-circle"></i> <%= profile.getName() %>
                            </div>
                            <div class="profile-id">
                                <i class="fas fa-id-card"></i> <%= profile.getStudentId() %>
                            </div>
                        </div>

                        <div class="profile-info">
                            <strong><i class="fas fa-graduation-cap"></i> Programme:</strong>
                            <%= profile.getProgramme() %>
                        </div>

                        <div class="profile-info">
                            <strong><i class="fas fa-envelope"></i> Email:</strong>
                            <%= profile.getEmail() %>
                        </div>

                        <div class="profile-info">
                            <strong><i class="fas fa-heart"></i> Hobbies:</strong>
                            <%= profile.getHobby() %>
                        </div>

                        <% if (profile.getBio() != null && !profile.getBio().isEmpty()) { %>
                            <div class="profile-bio">
                                <i class="fas fa-quote-left"></i> <%= profile.getBio() %>
                            </div>
                        <% } %>

                        <div class="action-buttons">
                            <a href="ProfileServlet?action=edit&id=<%= profile.getId() %>" class="btn btn-edit">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="ProfileServlet?action=delete&id=<%= profile.getId() %>" 
                               class="btn btn-delete"
                               onclick="return confirm('Are you sure you want to delete this profile?')">
                                <i class="fas fa-trash"></i> Delete
                            </a>
                        </div>
                    </div>
                <%
                    }
                %>
            </div>
        <%
            } else {
        %>
            <div class="no-profiles">
                <i class="fas fa-inbox" style="font-size: 48px; color: #bdc3c7; margin-bottom: 20px;"></i>
                <p>No profiles found. Add your first profile!</p>
            </div>
        <%
            }
        %>
    </div>

    <script>
        const snowContainer = document.getElementById("snow");
        for(let i = 0; i < 50; i++){
            const snowflake = document.createElement("div");
            snowflake.classList.add("snowflake");
            const size = Math.random() * 5 + 3;
            snowflake.style.width = size + "px";
            snowflake.style.height = size + "px";
            snowflake.style.left = Math.random() * 100 + "%";
            snowflake.style.animationDuration = (Math.random() * 10 + 5) + "s";
            snowflake.style.animationDelay = Math.random() * 10 + "s";
            snowContainer.appendChild(snowflake);
        }
    </script>
</body>
</html>