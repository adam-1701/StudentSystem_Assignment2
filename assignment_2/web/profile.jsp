<%@ page contentType="text/html;charset=UTF-8" language="java" %>  
<!DOCTYPE html>
<html>
<head>
    <title>Profile Saved Successfully</title>
    <style>
        body {
            font-family: "Poppins", sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            position: relative;
            background: linear-gradient(135deg, #ff9f80, #ffe066, #6a4c93, #ff6f91, #ffb347, #c44569);
            background-size: 1200% 1200%;
            animation: gradientMove 20s ease infinite;
        }

        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .background-spot {
            position: absolute;
            border-radius: 50%;
            opacity: 0.3;
            z-index: 0;
            mix-blend-mode: screen;
        }
        .spot1 { width: 400px; height: 400px; background: radial-gradient(circle, #ff6f91, #ff9671); top: -80px; left: -100px; }
        .spot2 { width: 350px; height: 350px; background: radial-gradient(circle, #6a4c93, #c44569); bottom: -100px; right: -120px; }
        .spot3 { width: 250px; height: 250px; background: radial-gradient(circle, #ffe066, #ffb347); top: 100px; right: -80px; }

        .particles {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            z-index: 1;
            pointer-events: none;
            background-image:
                radial-gradient(circle, rgba(255,255,255,0.15) 2%, transparent 2%),
                radial-gradient(circle, rgba(255,255,255,0.15) 2%, transparent 2%);
            background-size: 40px 40px, 60px 60px;
            animation: moveParticles 30s linear infinite;
        }

        @keyframes moveParticles {
            0% { background-position: 0 0, 0 0; }
            100% { background-position: 800px 800px, 600px 600px; }
        }

        .snow {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            pointer-events: none;
            z-index: 100;
            overflow: hidden;
        }

        .snowflake {
            position: absolute;
            top: -10px;
            background: white;
            border-radius: 50%;
            opacity: 0.9;
            filter: blur(2px);
            animation-name: fall;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
        }

        @keyframes fall {
            0% { transform: translateY(0px) translateX(0px); opacity: 1; }
            100% { transform: translateY(100vh) translateX(-20px); opacity: 0.6; }
        }

        .profile {
            background: rgba(245, 211, 206, 0.95);
            padding: 40px;
            width: 520px;
            max-height: 90vh;
            overflow-y: auto;
            border-radius: 25px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.3);
            position: relative;
            z-index: 5;
            border: 4px solid;
            border-image-slice: 1;
            border-image-source: linear-gradient(45deg, #ff9f80, #ffe066, #6a4c93, #ff6f91);
        }

        .success-badge {
            background: linear-gradient(135deg, #4CAF50, #45a049);
            color: white;
            padding: 15px;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 25px;
            font-weight: bold;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
        }

        h2 {
            text-align: center;
            color: #381a04;
            margin-bottom: 30px;
            font-size: 28px;
            letter-spacing: 1px;
        }

        .info-box {
            background: #6fe3f7;
            padding: 14px 18px;
            border-radius: 12px;
            border-left: 5px solid #d0874a;
            margin-bottom: 14px;
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .info-box:hover {
            transform: scale(1.02);
            box-shadow: 0 8px 20px rgba(208, 135, 74, 0.4);
        }

        .info-box strong {
            color: #2c3e50;
            display: block;
            margin-bottom: 6px;
            font-size: 15px;
            font-weight: 600;
        }

        .info-box span {
            color: #34495e;
            font-size: 15px;
        }

        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 25px;
        }

        .btn {
            flex: 1;
            text-align: center;
            padding: 14px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.3s;
            cursor: pointer;
        }

        .btn-primary {
            background: #d0874a;
            color: white;
        }

        .btn-primary:hover {
            background: #b46b2a;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: #3498db;
            color: white;
        }

        .btn-secondary:hover {
            background: #2980b9;
            transform: translateY(-2px);
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <div class="background-spot spot1"></div>
    <div class="background-spot spot2"></div>
    <div class="background-spot spot3"></div>
    <div class="particles"></div>
    <div class="snow" id="snow"></div>

    <div class="profile">
        <div class="success-badge">
            <i class="fas fa-check-circle"></i> Profile Saved Successfully to Database!
        </div>

        <h2>Your Personal Profile</h2>

        <div class="info-box">
            <strong><i class="fas fa-user"></i> Name</strong>
            <span><%= request.getAttribute("name") %></span>
        </div>

        <div class="info-box">
            <strong><i class="fas fa-id-badge"></i> Student ID</strong>
            <span><%= request.getAttribute("studentId") %></span>
        </div>

        <div class="info-box">
            <strong><i class="fas fa-graduation-cap"></i> Program</strong>
            <span><%= request.getAttribute("program") %></span>
        </div>

        <div class="info-box">
            <strong><i class="fas fa-envelope"></i> Email</strong>
            <span><%= request.getAttribute("email") %></span>
        </div>

        <div class="info-box">
            <strong><i class="fas fa-heart"></i> Hobbies</strong>
            <span><%= request.getAttribute("hobbies") %></span>
        </div>

        <div class="info-box">
            <strong><i class="fas fa-pen"></i> About Me</strong>
            <span><%= request.getAttribute("selfIntro") %></span>
        </div>

        <div class="button-group">
            <a href="index.html" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add Another Profile
            </a>
            <a href="ProfileServlet?action=viewAll" class="btn btn-secondary">
                <i class="fas fa-list"></i> View All Profiles
            </a>
        </div>
    </div>

    <script>
        const snowContainer = document.getElementById("snow");
        const snowCount = 50;
        for(let i = 0; i < snowCount; i++){
            const snowflake = document.createElement("div");
            snowflake.classList.add("snowflake");
            const size = Math.random() * 6 + 4;
            snowflake.style.width = `${size}px`;
            snowflake.style.height = `${size}px`;
            snowflake.style.left = `${Math.random() * window.innerWidth}px`;
            snowflake.style.animationDuration = `${Math.random() * 10 + 5}s`;
            snowflake.style.animationDelay = `${Math.random() * 10}s`;
            snowContainer.appendChild(snowflake);
        }
    </script>
</body>
</html>