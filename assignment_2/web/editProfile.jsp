<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.assignment2.bean.ProfileBeans" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Profile</title>
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
            max-width: 600px;
            margin: 0 auto;
            position: relative;
            z-index: 2;
        }

        .edit-card {
            background: rgba(255, 250, 240, 0.95);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            border: 3px solid;
            border-image-slice: 1;
            border-image-source: linear-gradient(45deg, #ff9f80, #6a4c93);
        }

        h1 {
            text-align: center;
            color: #381a04;
            margin-bottom: 30px;
            font-size: 32px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 8px;
            font-size: 15px;
        }

        label i {
            margin-right: 8px;
            color: #d0874a;
        }

        input[type="text"],
        input[type="email"],
        select,
        textarea {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #d0874a;
            border-radius: 10px;
            font-size: 15px;
            font-family: "Poppins", sans-serif;
            background: white;
            transition: all 0.3s;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        select:focus,
        textarea:focus {
            outline: none;
            border-color: #6a4c93;
            box-shadow: 0 0 10px rgba(106, 76, 147, 0.3);
        }

        input[readonly] {
            background: #f0f0f0;
            cursor: not-allowed;
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            flex: 1;
            padding: 14px 25px;
            border: none;
            border-radius: 10px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s;
            font-size: 16px;
        }

        .btn-update {
            background: #27ae60;
            color: white;
        }

        .btn-update:hover {
            background: #229954;
            transform: translateY(-2px);
        }

        .btn-cancel {
            background: #95a5a6;
            color: white;
        }

        .btn-cancel:hover {
            background: #7f8c8d;
            transform: translateY(-2px);
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="snow" id="snow"></div>

    <div class="container">
        <div class="edit-card">
            <h1><i class="fas fa-user-edit"></i> Edit Profile</h1>

            <%
                ProfileBeans profile = (ProfileBeans) request.getAttribute("profile");
                if (profile != null) {
            %>
                <form action="ProfileServlet" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="<%= profile.getId() %>">

                    <div class="form-group">
                        <label><i class="fas fa-id-card"></i> Student ID</label>
                        <input type="text" name="studentId" value="<%= profile.getStudentId() %>" readonly>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-user"></i> Name</label>
                        <input type="text" name="name" value="<%= profile.getName() %>" required>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-envelope"></i> Email</label>
                        <input type="email" name="email" value="<%= profile.getEmail() %>" required>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-graduation-cap"></i> Programme</label>
                        <select name="programme" required>
                            <option value="">-- Select Programme --</option>
                            <option value="Computer Science" 
                                <%= "Computer Science".equals(profile.getProgramme()) ? "selected" : "" %>>
                                Computer Science
                            </option>
                            <option value="Information Technology" 
                                <%= "Information Technology".equals(profile.getProgramme()) ? "selected" : "" %>>
                                Information Technology
                            </option>
                            <option value="Software Engineering" 
                                <%= "Software Engineering".equals(profile.getProgramme()) ? "selected" : "" %>>
                                Software Engineering
                            </option>
                            <option value="Data Science" 
                                <%= "Data Science".equals(profile.getProgramme()) ? "selected" : "" %>>
                                Data Science
                            </option>
                            <option value="Cybersecurity" 
                                <%= "Cybersecurity".equals(profile.getProgramme()) ? "selected" : "" %>>
                                Cybersecurity
                            </option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-heart"></i> Hobbies</label>
                        <input type="text" name="hobby" value="<%= profile.getHobby() != null ? profile.getHobby() : "" %>">
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-pencil-alt"></i> About Me</label>
                        <textarea name="bio"><%= profile.getBio() != null ? profile.getBio() : "" %></textarea>
                    </div>

                    <div class="button-group">
                        <button type="submit" class="btn btn-update">
                            <i class="fas fa-save"></i> Update Profile
                        </button>
                        <a href="ProfileServlet?action=viewAll" class="btn btn-cancel">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
            <%
                } else {
            %>
                <p style="text-align: center; color: #e74c3c;">
                    <i class="fas fa-exclamation-triangle"></i> Profile not found!
                </p>
                <div style="text-align: center; margin-top: 20px;">
                    <a href="ProfileServlet?action=viewAll" class="btn btn-cancel">
                        <i class="fas fa-arrow-left"></i> Back to Profiles
                    </a>
                </div>
            <%
                }
            %>
        </div>
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