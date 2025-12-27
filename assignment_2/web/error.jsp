<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title><%= request.getAttribute("errorTitle") != null ? request.getAttribute("errorTitle") : "Error" %></title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: calc(100vh - 60px);
        }

        .error-card {
            background: rgba(255, 250, 240, 0.95);
            padding: 50px;
            width: 100%;
            max-width: 500px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            border-left: 5px solid #e74c3c;
            text-align: center;
        }

        .error-icon {
            font-size: 48px;
            color: #e74c3c;
            margin-bottom: 20px;
        }

        h2 {
            color: #381a04;
            margin-bottom: 20px;
            font-size: 28px;
        }

        p {
            color: #555;
            margin-bottom: 30px;
            font-size: 16px;
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
            background: #e74c3c;
            color: white;
        }

        .btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="snow" id="snow"></div>

    <div class="container">
        <div class="error-card">
            <div class="error-icon">
                <i class="fas fa-exclamation-triangle"></i>
            </div>
            <h2><%= request.getAttribute("errorTitle") != null ? request.getAttribute("errorTitle") : "Error" %></h2>
            <p><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "An unknown error occurred." %></p>
            <a href="index.html" class="btn">
                <i class="fas fa-arrow-left"></i> Go Back
            </a>
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