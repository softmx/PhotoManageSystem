<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dao.*, java.util.*" %>
<!DOCTYPE html>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>账户安全 - 修改密码</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4cc9f0;
            --error-color: #f72585;
            --border-radius: 10px;
            --box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }
        
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f5 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            color: var(--dark-color);
            line-height: 1.6;
        }
        
        .password-container {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2.5rem;
            width: 100%;
            max-width: 500px;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }
        
        .password-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary-color), var(--success-color));
        }
        
        .password-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .password-header i {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .password-header h2 {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        
        .password-header p {
            color: #6c757d;
            font-size: 0.95rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
            position: relative;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #495057;
            font-size: 0.95rem;
        }
        
        .form-group i {
            position: absolute;
            left: 15px;
            top: 42px;
            color: #adb5bd;
        }
        
        .form-control {
            width: 100%;
            padding: 0.8rem 1rem 0.8rem 40px;
            border: 1px solid #e0e0e0;
            border-radius: var(--border-radius);
            font-size: 0.95rem;
            transition: var(--transition);
            background-color: #f8f9fa;
        }
        
        .form-control:focus {
            border-color: var(--accent-color);
            background-color: white;
            box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.2);
            outline: none;
        }
        
        .btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            border: none;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 1rem;
        }
        
        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(67, 97, 238, 0.4);
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
        }
        
        .btn:active {
            transform: translateY(0);
        }
        
        .alert {
            padding: 0.8rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            text-align: center;
        }
        
        .alert-error {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--error-color);
            border: 1px solid rgba(247, 37, 133, 0.2);
        }
        
        .alert-success {
            background-color: rgba(76, 201, 240, 0.1);
            color: var(--success-color);
            border: 1px solid rgba(76, 201, 240, 0.2);
        }
        
        .back-link {
            display: inline-block;
            margin-top: 1.5rem;
            color: var(--primary-color);
            text-decoration: none;
            font-size: 0.9rem;
            transition: var(--transition);
            text-align: center;
            width: 100%;
        }
        
        .back-link:hover {
            color: var(--secondary-color);
            text-decoration: underline;
        }
        
        @media (max-width: 576px) {
            .password-container {
                padding: 1.5rem;
            }
            
            .password-header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="password-container">
        <div class="password-header">
            <i class="fas fa-lock"></i>
            <h2>修改密码</h2>
            <p>为了您的账户安全，请定期更新密码</p>
        </div>
        
        <% if (request.getAttribute("msg") != null) { %>
            <div class="alert <%= request.getAttribute("success") != null ? "alert-success" : "alert-error" %>">
                <%= request.getAttribute("msg") %>
            </div>
        <% } %>
        
        <form method="post" action="changePassword">
            <div class="form-group">
                <label for="oldPassword">原密码</label>
                <i class="fas fa-key"></i>
                <input type="password" id="oldPassword" name="oldPassword" class="form-control" placeholder="请输入当前密码" required>
            </div>
            
            <div class="form-group">
                <label for="newPassword">新密码</label>
                <i class="fas fa-lock"></i>
                <input type="password" id="newPassword" name="newPassword" class="form-control" placeholder="请输入新密码" required>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">确认新密码</label>
                <i class="fas fa-check-circle"></i>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="请再次输入新密码" required>
            </div>
            
            <button type="submit" class="btn">
                <i class="fas fa-save"></i> 确认修改
            </button>
        </form>
        
        <a href="upload.jsp" class="back-link">
            <i class="fas fa-arrow-left"></i> 返回上传页面
        </a>
    </div>
</body>
</html>