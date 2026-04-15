<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*, java.util.*, dao.CommentDao"%>
<%
    List<Image> images = (List<Image>) request.getAttribute("images");
    CommentDao commentDao = new CommentDao();
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>图片展示</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        
        body {
            background-color: #f5f5f5;
            padding: 20px;
            color: #333;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .header h2 {
            font-size: 28px;
            font-weight: 600;
            color: #333;
            position: relative;
            display: inline-block;
        }
        
        .header h2::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 50px;
            height: 3px;
            background: linear-gradient(to right, #4facfe, #00f2fe);
            border-radius: 3px;
        }
        
        .gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }
        
        .image-card {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .image-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
        }
        
        .image-content {
            padding: 20px;
        }
        
        .image-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 10px;
            color: #444;
        }
        
        .image-display {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 6px;
            margin-bottom: 15px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }
        
        .image-description {
            color: #666;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .comments-section {
            margin-top: 20px;
            border-top: 1px solid #eee;
            padding-top: 15px;
        }
        
        .comments-title {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 15px;
            color: #444;
        }
        
        .comment {
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px dashed #eee;
        }
        
        .comment:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }
        
        .comment-user {
            font-weight: 600;
            color: #4facfe;
            margin-right: 5px;
        }
        
        .comment-content {
            color: #555;
            line-height: 1.5;
            margin: 5px 0;
        }
        
        .comment-time {
            font-size: 12px;
            color: #999;
        }
        
        .comment-form {
            margin-top: 20px;
        }
        
        .comment-textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            resize: vertical;
            min-height: 80px;
            margin-bottom: 10px;
            transition: border-color 0.3s;
        }
        
        .comment-textarea:focus {
            border-color: #4facfe;
            outline: none;
            box-shadow: 0 0 0 3px rgba(79, 172, 254, 0.1);
        }
        
        .comment-submit {
            background: linear-gradient(to right, #4facfe, #00f2fe);
            color: white;
            border: none;
            border-radius: 6px;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .comment-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(79, 172, 254, 0.3);
        }
        
        .login-prompt {
            text-align: center;
            margin-top: 15px;
            color: #666;
        }
        
        .login-link {
            color: #4facfe;
            text-decoration: none;
            font-weight: 500;
        }
        
        .login-link:hover {
            text-decoration: underline;
        }
        
        @media (max-width: 768px) {
            .gallery {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
        <form method="get" action="gallery" style="text-align: center; margin-bottom: 20px;">
    <input type="text" name="q" placeholder="搜索标题或描述..."
           value="<%= request.getAttribute("q") == null ? "" : request.getAttribute("q") %>"
           style="width: 300px; padding: 8px; border-radius: 5px; border: 1px solid #ccc;">

    <select name="typeId" style="padding: 8px; border-radius: 5px; border: 1px solid #ccc;">
        <option value="">全部类型</option>
        <%
            List<ImageType> types = (List<ImageType>) request.getAttribute("types");
            Integer selectedTypeId = (Integer) request.getAttribute("selectedTypeId");

            for (ImageType type : types) {
                boolean selected = selectedTypeId != null && selectedTypeId == type.getId();
        %>
            <option value="<%= type.getId() %>" <%= selected ? "selected" : "" %>><%= type.getName() %></option>
        <%
            }
        %>
    </select>

    <button type="submit"
            style="padding: 8px 16px; border: none; border-radius: 5px; background-color: #4facfe; color: white; font-weight: bold; cursor: pointer;">
        搜索
    </button>
</form>
        
            <h2>公开图片</h2>
        </div>
        
        <div class="gallery">
            <% for (Image img : images) { %>
                <div class="image-card">
                    <img src="<%= img.getUrl() %>" class="image-display" alt="<%= img.getTitle() %>">
                    
                    <div class="image-content">
                        <h3 class="image-title"><%= img.getTitle() %></h3>
                        <p class="image-description"><%= img.getDescription() %></p>
                        
                        <div class="comments-section">
                            <h4 class="comments-title">评论</h4>
                            
                            <%
                                List<Comment> comments = commentDao.getByImageId(img.getId());
                                for (Comment c : comments) {
                            %>
                                <div class="comment">
                                    <span class="comment-user"><%= c.getUsername() %></span>
                                    <p class="comment-content"><%= c.getContent() %></p>
                                    <span class="comment-time"><%= c.getCommentTime() %></span>
                                </div>
                            <%
                                }
                            %>
                            
                            <% if (user != null) { %>
                                <form action="comment" method="post" class="comment-form">
                                    <input type="hidden" name="imageId" value="<%= img.getId() %>">
                                    <textarea name="content" class="comment-textarea" placeholder="写下你的评论..."></textarea>
                                    <button type="submit" class="comment-submit">发表评论</button>
                                </form>
                            <% } else { %>
                                <p class="login-prompt">
                                    <a href="index.jsp" class="login-link">登录后发表评论</a>
                                </p>
                            <% } %>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>