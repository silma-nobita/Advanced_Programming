<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String user = String.valueOf(session.getAttribute("username"));
%>
<html>
<head>
    <title>Dashboard - Ocean View</title>
    <style>
        body{
            font-family: Arial, sans-serif;
            background:#f5f6fa;
            margin:0;
            padding:20px;
        }
        .wrap{
            max-width: 900px;
            margin: 0 auto;
        }
        .card{
            background:#ffffff;
            border:1px solid #e5e7eb;
            border-radius:12px;
            padding:18px 20px;
            box-shadow:0 8px 18px rgba(0,0,0,0.06);
        }
        .top{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:12px;
        }
        h2{ margin:0; }
        .muted{ color:#64748b; margin-top:6px; }
        .divider{
            height:1px;
            background:#e5e7eb;
            margin:16px 0;
        }
        .menu{
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap:12px;
        }
        .item{
            display:block;
            padding:14px;
            border:1px solid #e5e7eb;
            border-radius:12px;
            background:#fafafa;
            text-decoration:none;
            color:#0f172a;
        }
        .item:hover{
            border-color:#cbd5e1;
            background:#f8fafc;
        }
        .item-title{
            font-weight:800;
            margin:0 0 6px 0;
        }
        .item-desc{
            margin:0;
            color:#64748b;
            font-size:13px;
        }
        .actions{
            display:flex;
            justify-content:flex-end;
            margin-top:14px;
        }
        .logout{
            padding:10px 14px;
            background:#dc2626;
            color:#fff;
            font-weight:800;
            border-radius:10px;
            text-decoration:none;
        }
        .logout:hover{ opacity:0.95; }

        @media (max-width:700px){
            .menu{ grid-template-columns: 1fr; }
            .top{ flex-direction:column; align-items:flex-start; }
        }
    </style>
</head>
<body>

<div class="wrap">
    <div class="card">
        <div class="top">
            <div>
                <h2>Welcome, <%= user %> ✅</h2>
                <div class="muted">You are logged in. Choose an option from the menu below.</div>
            </div>
        </div>

        <div class="divider"></div>

        <h3 style="margin:0 0 10px 0;">Menu</h3>

        <div class="menu">
            <a class="item" href="addReservation.jsp">
                <div class="item-title">Add Reservation</div>
                <p class="item-desc">Create a new booking and save it to the database.</p>
            </a>

            <a class="item" href="viewReservation.jsp">
                <div class="item-title">View Reservation</div>
                <p class="item-desc">Search by reservation number and view details.</p>
            </a>

            <a class="item" href="allReservations">
                <div class="item-title">All Reservations</div>
                <p class="item-desc">View all bookings, and edit or delete them.</p>
            </a>

            <a class="item" href="help.jsp">
                <div class="item-title">Help</div>
                <p class="item-desc">Search help topics (add reservation, print bill, logout).</p>
            </a>
        </div>

        <div class="divider"></div>

        <div class="actions">
            <a class="logout" href="logout">Logout</a>
        </div>
    </div>
</div>

</body>
</html>