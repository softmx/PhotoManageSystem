<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*,java.util.*"%>
<!DOCTYPE html>
<html>
<head>
    <title>图片上传中心</title>
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
            --warning-color: #f72585;
            --border-radius: 12px;
            --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
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
            padding: 2rem;
            color: var(--dark-color);
            line-height: 1.6;
        }
        
        .container {
            max-width: 800px;
            margin: 0 auto;
            animation: fadeIn 0.5s ease-out;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
        
        .welcome {
            font-size: 1.1rem;
            font-weight: 500;
            color: var(--dark-color);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .welcome i {
            color: var(--accent-color);
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.6rem 1.2rem;
            border-radius: var(--border-radius);
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: var(--transition);
            border: none;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            box-shadow: 0 4px 15px rgba(67, 97, 238, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(67, 97, 238, 0.4);
        }
        
        .btn-outline {
            background: transparent;
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
        }
        
        .btn-outline:hover {
            background: rgba(67, 97, 238, 0.1);
        }
        
        .upload-container {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2.5rem;
            transition: var(--transition);
            overflow: hidden;
            position: relative;
        }
        
        .upload-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 5px;
            height: 100%;
            background: linear-gradient(to bottom, var(--primary-color), var(--success-color));
        }
        
        .upload-container:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
        }
        
        .upload-header {
            margin-bottom: 2rem;
            text-align: center;
            position: relative;
        }
        
        .upload-header h2 {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--dark-color);
            margin-bottom: 1rem;
        }
        
        .upload-header p {
            color: #6c757d;
            font-size: 0.95rem;
            max-width: 80%;
            margin: 0 auto;
        }
        
        .upload-icon {
            font-size: 2.5rem;
            color: var(--accent-color);
            margin-bottom: 1rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #495057;
            font-size: 0.95rem;
        }
        
        .form-control {
            width: 100%;
            padding: 0.8rem 1rem;
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
        
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }
        
        .file-upload-wrapper {
            position: relative;
            margin-bottom: 1rem;
        }
        
        .file-upload-label {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            border: 2px dashed #dee2e6;
            border-radius: var(--border-radius);
            background-color: #f8f9fa;
            cursor: pointer;
            transition: var(--transition);
            text-align: center;
        }
        
        .file-upload-label:hover {
            border-color: var(--accent-color);
            background-color: rgba(72, 149, 239, 0.05);
        }
        
        .file-upload-label i {
            font-size: 1.8rem;
            color: var(--accent-color);
            margin-bottom: 0.5rem;
        }
        
        .file-upload-label span {
            color: #6c757d;
            font-size: 0.9rem;
        }
        
        .file-upload-label strong {
            color: var(--primary-color);
            font-weight: 500;
        }
        
        .file-upload-input {
            position: absolute;
            left: 0;
            top: 0;
            opacity: 0;
            width: 100%;
            height: 100%;
            cursor: pointer;
        }
        
        .checkbox-container {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
        }
        
        .checkbox-container input[type="checkbox"] {
            width: 18px;
            height: 18px;
            margin-right: 0.75rem;
            accent-color: var(--primary-color);
            cursor: pointer;
        }
        
        .checkbox-container label {
            font-size: 0.95rem;
            color: #495057;
            cursor: pointer;
        }
        
        .submit-btn {
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
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(67, 97, 238, 0.4);
            background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
        }
        
        .submit-btn:active {
            transform: translateY(0);
        }
        
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }
            
            .upload-container {
                padding: 1.5rem;
            }
            
            .header {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
            
            .action-buttons {
                width: 100%;
                justify-content: space-between;
            }
            
            .btn {
                flex: 1;
                text-align: center;
            }
        }
        
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
<%
    model.User user = (model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
    <div class="container">
        <div class="header">
            <div class="welcome">
                <i class="fas fa-user-circle"></i>
                <span>欢迎回来，<strong><%= user.getUsername() %></strong>！</span>
            </div>
            <div class="action-buttons">
                <a href="profile" class="btn btn-outline">
                    <i class="fas fa-key"></i> 个人主页
                </a>
                <a href="logout" class="btn btn-primary">
                    <i class="fas fa-sign-out-alt"></i> 退出登录
                </a>
            </div>
        </div>
        
        <div class="upload-container">
            <div class="upload-header">
                <div class="upload-icon">
                    <i class="fas fa-cloud-upload-alt"></i>
                </div>
                <h2>分享你的精彩瞬间</h2>
                <p>上传你的照片并与社区分享，支持JPG、PNG格式，最大10MB</p>
            </div>
            
            <form action="upload" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="title"><i class="fas fa-heading"></i> 图片标题</label>
                    <input type="text" id="title" name="title" class="form-control" placeholder="为你的图片起个吸引人的标题">
                </div>
                
                <div class="form-group">
                    <label for="description"><i class="fas fa-align-left"></i> 图片描述</label>
                    <textarea id="description" name="description" class="form-control" placeholder="描述一下这张图片的故事或背景..."></textarea>
                </div>
                
                <div class="form-group">
                    <label for="typeId"><i class="fas fa-tags"></i> 图片分类</label>
                    <select id="typeId" name="typeId" class="form-control">
                        <option value="3">风景</option>
                        <option value="1">人物</option>
                        <option value="2">动物</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label><i class="fas fa-image"></i> 选择图片</label>
                    <div class="file-upload-wrapper">
                        <label class="file-upload-label" for="file-upload">
                            <i class="fas fa-file-image"></i>
                            <span>拖放文件到此处或 <strong>点击选择</strong></span>
                            <span>支持 JPG, PNG 格式</span>
                        </label>
                        <input type="file" id="file-upload" class="file-upload-input" name="image" accept="image/*" required>
                    </div>
                </div>
                
                <div class="checkbox-container">
                    <input type="checkbox" id="isPublic" name="isPublic" checked>
                    <label for="isPublic">公开此图片（允许其他用户查看）</label>
                </div>
                
                <button type="submit" class="submit-btn">
                    <i class="fas fa-upload"></i> 立即上传
                </button>
            </form>
        </div>
    </div>
</body>
</html>