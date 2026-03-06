<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Object found = request.getAttribute("found");
%>
<html>
<head>
    <title>Bill / Invoice</title>
    <style>
        body { font-family: Arial, sans-serif; background:#f5f6fa; margin:0; padding:20px; }
        .invoice { max-width: 700px; margin: 0 auto; background:#fff; padding:20px; border:1px solid #e5e7eb; border-radius:10px; }
        .top { display:flex; justify-content:space-between; align-items:flex-start; }
        .brand h2 { margin:0; }
        .muted { color:#64748b; }
        table { width:100%; border-collapse: collapse; margin-top:16px; }
        th, td { border:1px solid #e5e7eb; padding:10px; text-align:left; }
        th { background:#f1f5f9; }
        .total { text-align:right; font-size:18px; font-weight:700; margin-top:14px; }
        .actions { margin-top:18px; display:flex; gap:10px; }
        button, a.btn { padding:10px 14px; border:none; border-radius:8px; cursor:pointer; font-weight:700; }
        button { background:#2563eb; color:#fff; }
        a.btn { background:#0f172a; color:#fff; text-decoration:none; display:inline-block; }
        @media print {
            .actions { display:none; }
            body { background:#fff; padding:0; }
            .invoice { border:none; border-radius:0; }
        }
    </style>
</head>
<body>

<div class="invoice">
    <div class="top">
        <div class="brand">
            <h2>Ocean View Resort</h2>
            <div class="muted">Room Reservation Invoice</div>
        </div>
        <div class="muted">
            Printed by: <b><%= session.getAttribute("username") %></b>
        </div>
    </div>

    <hr>

    <%
        if (found != null && (boolean) found) {
    %>
    <p><b>Reservation No:</b> <%= request.getAttribute("reservation_no") %></p>
    <p><b>Guest Name:</b> <%= request.getAttribute("guest_name") %></p>
    <p><b>Room Type:</b> <%= request.getAttribute("room_type") %></p>

    <table>
        <tr>
            <th>Check-in</th>
            <th>Check-out</th>
            <th>Nights</th>
            <th>Rate / Night</th>
            <th>Total</th>
        </tr>
        <tr>
            <td><%= request.getAttribute("check_in") %></td>
            <td><%= request.getAttribute("check_out") %></td>
            <td><%= request.getAttribute("nights") %></td>
            <td>LKR <%= request.getAttribute("rate_per_night") %></td>
            <td>LKR <%= request.getAttribute("total_amount") %></td>
        </tr>
    </table>

    <div class="total">
        Grand Total: LKR <%= request.getAttribute("total_amount") %>
    </div>

    <div class="actions">
        <button onclick="window.print()">Print</button>
        <a class="btn" href="viewReservation.jsp">Back</a>
    </div>
    <%
    } else {
    %>
    <p style="color:red;">Invoice not found ❌</p>
    <div class="actions">
        <a class="btn" href="viewReservation.jsp">Back</a>
    </div>
    <%
        }
    %>
</div>

</body>
</html>