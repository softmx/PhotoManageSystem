<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="servlet.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>用户注册</title>
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
            --border-radius: 12px;
            --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            color: var(--dark-color);
        }
        
        .register-container {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2.5rem;
            width: 100%;
            max-width: 450px;
            text-align: center;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }
        
        .register-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary-color), var(--accent-color));
        }
        
        .register-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
        }
        
        .register-header {
            margin-bottom: 2rem;
        }
        
        .register-header h2 {
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            position: relative;
            display: inline-block;
        }
        
        .register-header h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: linear-gradient(to right, var(--primary-color), var(--accent-color));
            border-radius: 3px;
        }
        
        .register-header p {
            color: #6c757d;
            font-size: 0.95rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
            text-align: left;
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
        
        .password-strength {
            height: 4px;
            background-color: #e9ecef;
            border-radius: 2px;
            margin-top: 0.5rem;
            overflow: hidden;
            position: relative;
        }
        
        .password-strength::after {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            height: 100%;
            width: 0;
            background-color: var(--error-color);
            transition: width 0.3s ease;
        }
        
        .password-strength.weak::after {
            width: 30%;
            background-color: var(--error-color);
        }
        
        .password-strength.medium::after {
            width: 60%;
            background-color: #ffc107;
        }
        
        .password-strength.strong::after {
            width: 100%;
            background-color: var(--success-color);
        }
        
        .password-hint {
            font-size: 0.8rem;
            color: #6c757d;
            margin-top: 0.3rem;
            display: none;
        }
        
        .register-button {
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
            margin-top: 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }
        
        .register-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(67, 97, 238, 0.4);
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
        }
        
        .register-button:active {
            transform: translateY(0);
        }
        
        .message {
            padding: 0.8rem;
            border-radius: var(--border-radius);
            margin: 1.5rem 0;
            font-size: 0.9rem;
            text-align: center;
        }
        
        .error-message {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--error-color);
            border: 1px solid rgba(247, 37, 133, 0.2);
        }
        
        .login-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            margin-top: 1.5rem;
            color: var(--primary-color);
            text-decoration: none;
            font-size: 0.9rem;
            transition: var(--transition);
        }
        
        .login-link:hover {
            text-decoration: underline;
        }
        
        @media (max-width: 480px) {
            .register-container {
                padding: 1.5rem;
            }
            
            .register-header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h2>创建新账户</h2>
            <p>加入我们，开始分享你的精彩瞬间</p>
        </div>
        
        <% if(request.getAttribute("msg") != null) { %>
            <div class="message error-message">
                <%= request.getAttribute("msg") %>
            </div>
        <% } %>
        
        <form action="register" method="post" id="registerForm">
            <div class="form-group">
                <label for="username"><i class="fas fa-user"></i> 用户名</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="输入用户名" required>
            </div>
            
            <div class="form-group">
                <label for="password"><i class="fas fa-lock"></i> 密码</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="输入密码 (至少8位)" required minlength="8">
                <div class="password-strength" id="passwordStrength"></div>
                <div class="password-hint" id="passwordHint">密码应包含大小写字母和数字</div>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword"><i class="fas fa-check-circle"></i> 确认密码</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" placeholder="再次输入密码" required>
                <div id="passwordMatch" style="font-size:0.8rem; color:#6c757d; margin-top:0.3rem;"></div>
            </div>
            
            <button type="submit" class="register-button">
                <i class="fas fa-user-plus"></i> 注册账户
            </button>
        </form>
        
        <a href="index.jsp" class="login-link">
            <i class="fas fa-sign-in-alt"></i> 已有账户？立即登录
        </a>
    </div>
    
    <script>
        // 密码强度检测
        const passwordInput = document.getElementById('password');
        const passwordStrength = document.getElementById('passwordStrength');
        const passwordHint = document.getElementById('passwordHint');
        const confirmPasswordInput = document.getElementById('confirmPassword');
        const passwordMatch = document.getElementById('passwordMatch');
        const registerForm = document.getElementById('registerForm');
        
        passwordInput.addEventListener('input', function() {
            const password = this.value;
            let strength = '';
            
            // 显示密码提示
            passwordHint.style.display = 'block';
            
            if (password.length === 0) {
                passwordStrength.className = 'password-strength';
                passwordHint.style.display = 'none';
            } else if (password.length < 8) {
                strength = 'weak';
                passwordHint.textContent = '密码太短，至少需要8个字符';
            } else if (!/[A-Z]/.test(password) || !/[a-z]/.test(password) || !/[0-9]/.test(password)) {
                strength = 'medium';
                passwordHint.textContent = '密码强度中等，建议包含大小写字母和数字';
            } else {
                strength = 'strong';
                passwordHint.textContent = '密码强度高，安全性良好';
            }
            
            passwordStrength.className = 'password-strength ' + strength;
        });
        
        // 密码匹配检查
        confirmPasswordInput.addEventListener('input', function() {
            if (passwordInput.value !== this.value) {
                passwordMatch.textContent = '两次输入的密码不一致';
                passwordMatch.style.color = 'var(--error-color)';
            } else {
                passwordMatch.textContent = '密码匹配';
                passwordMatch.style.color = 'var(--success-color)';
            }
            
            if (this.value.length === 0) {
                passwordMatch.textContent = '';
            }
        });
        
        // 表单提交验证
        registerForm.addEventListener('submit', function(e) {
            if (passwordInput.value !== confirmPasswordInput.value) {
                e.preventDefault();
                passwordMatch.textContent = '两次输入的密码不一致，请检查';
                passwordMatch.style.color = 'var(--error-color)';
                confirmPasswordInput.focus();
            }
            
            if (passwordInput.value.length < 8) {
                e.preventDefault();
                passwordHint.style.display = 'block';
                passwordHint.textContent = '密码长度不足8位';
                passwordHint.style.color = 'var(--error-color)';
                passwordInput.focus();
            }
        });
    </script>
</body>
</html>