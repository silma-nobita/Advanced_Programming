<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<html>
<head>
  <title>Help</title>
  <style>
    body{font-family:Arial,sans-serif;background:#f5f6fa;margin:0;padding:20px}
    .box{max-width:850px;margin:0 auto;background:#fff;padding:18px 20px;border:1px solid #e5e7eb;border-radius:10px}
    input{padding:10px;width:70%;border:1px solid #cbd5e1;border-radius:8px}
    button{padding:10px 14px;border:none;border-radius:8px;background:#2563eb;color:#fff;font-weight:700;cursor:pointer}
    .card{margin-top:14px;padding:14px;border:1px solid #e5e7eb;border-radius:10px;background:#fafafa}
    .muted{color:#64748b}
  </style>
</head>
<body>

<div class="box">
  <h2>Help Center</h2>
  <p class="muted">Search your question (example: "add reservation", "print bill", "logout")</p>

  <form method="get" action="helpSearch">
    <input type="text" name="q" placeholder="Type your question..." required>
    <button type="submit">Search</button>
  </form>

  <%
    String q = (String) request.getAttribute("q");
    String answer = (String) request.getAttribute("answer");
    if (q != null) {
  %>
  <div class="card">
    <h3>Result for: "<%= q %>"</h3>
    <p><%= answer %></p>
  </div>
  <%
    }
  %>

  <div class="card">
    <h3>Quick Topics</h3>
    <ul>
      <li><b>Login:</b> Use your admin username and password to access the dashboard.</li>
      <li><b>Add Reservation:</b> Dashboard → Add Reservation → fill details → Save.</li>
      <li><b>View Reservation:</b> Dashboard → View Reservation → search by reservation number.</li>
      <li><b>Print Bill:</b> View Reservation → Print Bill → click Print.</li>
      <li><b>Logout:</b> Dashboard → Logout.</li>
    </ul>
  </div>

  <p><a href="dashboard.jsp">Back to Dashboard</a></p>
</div>

</body>
</html>