<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dao.*, java.util.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    List<Image> myImages = (List<Image>) request.getAttribute("myImages");
%>
<!DOCTYPE html>
<html>
<head>
    <title>个人中心 - 我的相册</title>
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
            color: var(--dark-color);
            line-height: 1.6;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
        
        .welcome-message {
            font-size: 1.8rem;
            font-weight: 600;
        }
        
        .welcome-message span {
            color: var(--primary-color);
        }
        
        .action-buttons {
            display: flex;
            gap: 15px;
        }
        
        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 10px 20px;
            border-radius: var(--border-radius);
            font-size: 0.95rem;
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            transition: var(--transition);
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
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 25px;
            position: relative;
            padding-left: 15px;
        }
        
        .section-title::before {
            content: '';
            position: absolute;
            left: 0;
            top: 5px;
            height: 70%;
            width: 4px;
            background: linear-gradient(to bottom, var(--primary-color), var(--accent-color));
            border-radius: 2px;
        }
        
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-top: 30px;
        }
        
        .image-card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
            transition: var(--transition);
        }
        
        .image-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.12);
        }
        
        .image-container {
            width: 100%;
            height: 200px;
            overflow: hidden;
        }
        
        .image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        
        .image-card:hover .image-container img {
            transform: scale(1.05);
        }
        
        .image-info {
            padding: 18px;
        }
        
        .image-title {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 10px;
            color: var(--dark-color);
        }
        
        .image-desc {
            font-size: 0.9rem;
            color: #6c757d;
            margin-bottom: 15px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .image-actions {
            display: flex;
            justify-content: flex-end;
        }
        
        .delete-btn {
            color: var(--error-color);
            background: rgba(247, 37, 133, 0.1);
            padding: 6px 12px;
            border-radius: 5px;
            font-size: 0.85rem;
            transition: var(--transition);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 5px;
        }
        
        .delete-btn:hover {
            background: rgba(247, 37, 133, 0.2);
        }
        
        .empty-state {
            text-align: center;
            padding: 50px 20px;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
        }
        
        .empty-icon {
            font-size: 3rem;
            color: #adb5bd;
            margin-bottom: 15px;
        }
        
        .empty-text {
            font-size: 1.1rem;
            color: #6c757d;
            margin-bottom: 20px;
        }
        
        .upload-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
        }
        
        .upload-link:hover {
            text-decoration: underline;
        }
        
        @media (max-width: 768px) {
            .profile-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }
            
            .action-buttons {
                width: 100%;
                justify-content: space-between;
            }
            
            .btn {
                flex: 1;
                justify-content: center;
            }
            
            .gallery {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="profile-header">
            <div class="welcome-message">
                欢迎回来，<span><%= user.getUsername() %></span> 👋
            </div>
            <div class="action-buttons">
                <a href="upload.jsp" class="btn btn-primary">
                    <i class="fas fa-cloud-upload-alt"></i> 上传图片
                </a>
                <a href="change_password.jsp" class="btn btn-outline">
                    <i class="fas fa-key"></i> 修改密码
                </a>
            </div>
        </div>
        
        <h2 class="section-title">我的图片库</h2>
        
        <% if (myImages != null && !myImages.isEmpty()) { %>
            <div class="gallery">
                <% for (Image img : myImages) { %>
                    <div class="image-card">
                        <div class="image-container">
                            <img src="<%= img.getUrl() %>" alt="<%= img.getTitle() %>">
                        </div>
                        <div class="image-info">
                            <h3 class="image-title"><%= img.getTitle() %></h3>
                            <p class="image-desc"><%= img.getDescription() %></p>
                            <div class="image-actions">
                                <a href="deleteImage?id=<%= img.getId() %>" class="delete-btn" onclick="return confirm('确定要删除这张图片吗？此操作不可撤销。')">
                                    <i class="fas fa-trash-alt"></i> 删除
                                </a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } else { %>
            <div class="empty-state">
                <div class="empty-icon">
                    <i class="far fa-images"></i>
                </div>
                <p class="empty-text">您还没有上传任何图片</p>
                <a href="upload.jsp" class="upload-link">
                    <i class="fas fa-plus"></i> 立即上传第一张图片
                </a>
            </div>
        <% } %>
    </div>
    
    <script>
        // 删除确认增强
        document.querySelectorAll('.delete-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (!confirm('确定要删除这张图片吗？此操作不可撤销。')) {
                    e.preventDefault();
                }
            });
        });
    </script>
</body>
