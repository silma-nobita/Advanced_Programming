<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  if (session.getAttribute("username") != null) {
    response.sendRedirect("dashboard.jsp");
    return;
  }

  String err = request.getParameter("error");
  String msg = request.getParameter("msg");
%>
<html>
<head>
  <title>Login - Ocean View Resort</title>
  <style>
    body{font-family:Arial,sans-serif;background:#f5f6fa;margin:0;padding:0}
    .box{width:360px;margin:90px auto;background:#fff;padding:22px 24px;border:1px solid #e5e7eb;border-radius:10px;box-shadow:0 8px 18px rgba(0,0,0,0.08)}
    h2{margin:0 0 14px 0}
    label{font-weight:600;font-size:14px}
    input{width:100%;padding:10px;margin-top:6px;border:1px solid #cbd5e1;border-radius:8px;outline:none}
    input:focus{border-color:#2563eb;box-shadow:0 0 0 3px rgba(37,99,235,0.15)}
    button{width:100%;padding:10px;border:none;border-radius:8px;background:#2563eb;color:white;font-weight:700;cursor:pointer;margin-top:14px}
    button:hover{opacity:0.95}
    .msg{margin-top:12px;padding:10px;border-radius:8px;font-size:14px}
    .error{background:#fee2e2;color:#991b1b;border:1px solid #fecaca}
    .success{background:#dcfce7;color:#166534;border:1px solid #bbf7d0}
    .hint{margin-top:12px;font-size:13px;color:#475569}
    .hint code{background:#f1f5f9;padding:2px 6px;border-radius:6px}
  </style>
</head>
<body>
<div class="box">
  <h2>Login</h2>

  <form method="post" action="login">
    <label>Username</label>
    <input type="text" name="username" placeholder="Enter username" required>

    <div style="height:10px;"></div>

    <label>Password</label>
    <input type="password" name="password" placeholder="Enter password" required>

    <button type="submit">Sign In</button>
  </form>

  <% if (err != null) { %>
  <div class="msg error">Invalid username or password ❌</div>
  <% } %>

  <% if ("loggedout".equals(msg)) { %>
  <div class="msg success">You have logged out ✅</div>
  <% } %>

  <div class="hint">
    Test user: <code>admin</code> / <code>admin123</code>
  </div>
</div>
</body>
</html>