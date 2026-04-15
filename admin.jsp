<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*, dao.*, java.util.*" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || user.getUserType() != 1) {  // 只允许管理员访问
        response.sendRedirect("index.jsp");
        return;
    }

    List<User> users = new UserDao().getAllUsers();
    List<model.Image> images = new ImageDao().getAllImages();
    if (users == null) {
        users = new ArrayList<User>();
    }
    if (images == null) {
        images = new ArrayList<Image>();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>管理员后台</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        }
        
        body {
            background-color: #f5f7fb;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }
        
        .admin-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #e0e0e0;
        }
        
        .header h1 {
            font-size: 28px;
            font-weight: 600;
            color: #444;
        }
        
        .logout-btn {
            background: linear-gradient(to right, #ff5e62, #ff9966);
            color: white;
            border: none;
            border-radius: 6px;
            padding: 8px 16px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(255, 94, 98, 0.3);
        }
        
        .section {
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 25px;
            margin-bottom: 30px;
        }
        
        .section-title {
            font-size: 22px;
            font-weight: 600;
            color: #444;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }
        
        .table-container {
            overflow-x: auto;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        th, td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        
        th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #555;
            position: sticky;
            top: 0;
        }
        
        tr:hover {
            background-color: #f9f9f9;
        }
        
        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }
        
        .delete-btn {
            background-color: #ffebee;
            color: #f44336;
        }
        
        .delete-btn:hover {
            background-color: #f44336;
            color: white;
        }
        
        .disabled-btn {
            background-color: #e0e0e0;
            color: #9e9e9e;
            cursor: not-allowed;
        }
        
        .icon {
            margin-right: 5px;
        }
        
        .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .badge-admin {
            background-color: #e3f2fd;
            color: #1976d2;
        }
        
        .badge-user {
            background-color: #e8f5e9;
            color: #388e3c;
        }
        
        .badge-public {
            background-color: #e8f5e9;
            color: #388e3c;
        }
        
        .badge-private {
            background-color: #ffebee;
            color: #d32f2f;
        }
        
        @media (max-width: 768px) {
            th, td {
                padding: 8px 10px;
                font-size: 14px;
            }
            
            .action-btn {
                padding: 4px 8px;
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <div class="header">
            <h1>管理员控制台</h1>
            <a href="logout" class="logout-btn">
                <i class="fas fa-sign-out-alt icon"></i>退出登录
            </a>
        </div>
        
        <div class="section">
            <h2 class="section-title">
                <i class="fas fa-users icon"></i>用户管理
            </h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>用户类型</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(User u : users) { %>
                            <tr>
                                <td><%= u.getId() %></td>
                                <td><%= u.getUsername() %></td>
                                <td>
                                    <span class="badge <%= u.getUserType() == 1 ? "badge-admin" : "badge-user" %>">
                                        <%= u.getUserType() == 1 ? "管理员" : "普通用户" %>
                                    </span>
                                </td>
                                <td>
                                    <% if(u.getUserType() != 1) { %>  
                                        <form action="adminAction" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="deleteUser">
                                            <input type="hidden" name="userId" value="<%= u.getId() %>">
                                            <button type="submit" class="action-btn delete-btn" 
                                                onclick="return confirm('确定删除用户 <%= u.getUsername() %> 吗？此操作不可恢复！')">
                                                <i class="fas fa-trash-alt icon"></i>删除用户
                                            </button>
                                        </form>
                                    <% } else { %>
                                        <button class="action-btn disabled-btn" disabled>
                                            <i class="fas fa-lock icon"></i>管理员保护
                                        </button>
                                    <% } %>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
        
        <div class="section">
            <h2 class="section-title">
                <i class="fas fa-images icon"></i>图片管理
            </h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>标题</th>
                            <th>上传者ID</th>
                            <th>公开状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Image img : images) { %>
                            <tr>
                                <td><%= img.getId() %></td>
                                <td><%= img.getTitle() %></td>
                                <td><%= img.getUploaderId() %></td>
                                <td>
                                    <span class="badge <%= img.isPublic() ? "badge-public" : "badge-private" %>">
                                        <%= img.isPublic() ? "公开" : "私有" %>
                                    </span>
                                </td>
                                <td>
                                    <form action="adminAction" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="deleteImage">
                                        <input type="hidden" name="imageId" value="<%= img.getId() %>">
                                        <button type="submit" class="action-btn delete-btn" 
                                            onclick="return confirm('确定删除图片 "<%= img.getTitle() %>" 吗？此操作不可恢复！')">
                                            <i class="fas fa-trash-alt icon"></i>删除图片
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>