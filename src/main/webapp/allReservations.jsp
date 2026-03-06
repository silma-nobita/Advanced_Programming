<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String reservationNo = (String) request.getAttribute("reservationNo");
    String guestName = (String) request.getAttribute("guestName");
    String contact = (String) request.getAttribute("contact");
    String roomType = (String) request.getAttribute("roomType");

    if (reservationNo == null) reservationNo = "";
    if (guestName == null) guestName = "";
    if (contact == null) contact = "";
    if (roomType == null) roomType = "ALL";

    Integer totalCount = (Integer) request.getAttribute("totalCount");
    Integer filteredCount = (Integer) request.getAttribute("filteredCount");
%>
<html>
<head>
    <title>All Reservations</title>
    <style>
        body{font-family:Arial,sans-serif;background:#f5f6fa;margin:0;padding:20px}
        .box{max-width:1100px;margin:0 auto;background:#fff;padding:18px 20px;border:1px solid #e5e7eb;border-radius:12px;box-shadow:0 8px 18px rgba(0,0,0,0.06)}
        .filters{display:grid;grid-template-columns:1fr 1fr 1fr 1fr;gap:10px;align-items:end}
        label{font-weight:800;font-size:13px;color:#0f172a}
        input,select{width:100%;padding:10px;border:1px solid #cbd5e1;border-radius:10px;outline:none;box-sizing:border-box}
        input:focus,select:focus{border-color:#2563eb;box-shadow:0 0 0 3px rgba(37,99,235,0.15)}
        .actions{display:flex;gap:10px;flex-wrap:wrap;margin-top:12px}
        button,a.btn{padding:10px 14px;border:none;border-radius:10px;font-weight:800;cursor:pointer;text-decoration:none;display:inline-block}
        button{background:#2563eb;color:#fff}
        a.btn{background:#0f172a;color:#fff}
        table{width:100%;border-collapse:collapse;margin-top:14px}
        th,td{border:1px solid #e5e7eb;padding:10px;text-align:left}
        th{background:#f1f5f9}
        .btnMini{padding:6px 10px;border-radius:10px;font-weight:800;text-decoration:none;display:inline-block}
        .view{background:#0f172a;color:#fff}
        .edit{background:#2563eb;color:#fff}
        .del{background:#dc2626;color:#fff;border:none}
        form.inline{display:inline}
        .muted{color:#64748b;margin-top:8px}
        @media(max-width:900px){ .filters{grid-template-columns:1fr 1fr} }
        @media(max-width:600px){ .filters{grid-template-columns:1fr} }
    </style>
</head>
<body>

<div class="box">
    <h2 style="margin:0 0 10px 0;">All Reservations</h2>

    <form method="get" action="allReservations">
        <div class="filters">
            <div>
                <label>Reservation No</label>
                <input type="text" name="reservationNo" value="<%= reservationNo %>" placeholder="e.g., R001">
            </div>

            <div>
                <label>Guest Name</label>
                <input type="text" name="guestName" value="<%= guestName %>" placeholder="e.g., Nimal">
            </div>

            <div>
                <label>Contact</label>
                <input type="text" name="contact" value="<%= contact %>" placeholder="e.g., 077">
            </div>

            <div>
                <label>Room Type</label>
                <select name="roomType">
                    <option value="ALL" <%= "ALL".equals(roomType) ? "selected" : "" %>>All</option>
                    <option value="Single" <%= "Single".equalsIgnoreCase(roomType) ? "selected" : "" %>>Single</option>
                    <option value="Double" <%= "Double".equalsIgnoreCase(roomType) ? "selected" : "" %>>Double</option>
                    <option value="Deluxe" <%= "Deluxe".equalsIgnoreCase(roomType) ? "selected" : "" %>>Deluxe</option>
                </select>
            </div>
        </div>

        <div class="actions">
            <button type="submit">Apply Filters</button>
            <a class="btn" href="allReservations">Clear</a>
        </div>
    </form>

    <div class="muted">
        Showing <b><%= (filteredCount == null ? 0 : filteredCount) %></b>
        of <b><%= (totalCount == null ? 0 : totalCount) %></b> reservations
    </div>

    <%
        java.util.List<com.oceanview.model.Reservation> list =
                (java.util.List<com.oceanview.model.Reservation>) request.getAttribute("list");
        if (list == null || list.isEmpty()) {
    %>
    <p style="margin-top:14px;">No reservations found.</p>
    <%
    } else {
    %>
    <table>
        <tr>
            <th>Reservation No</th>
            <th>Guest</th>
            <th>Room</th>
            <th>Check-in</th>
            <th>Check-out</th>
            <th>Total</th>
            <th>Actions</th>
        </tr>

        <% for (com.oceanview.model.Reservation r : list) { %>
        <tr>
            <td><%= r.getReservationNo() %></td>
            <td><%= r.getGuestName() %></td>
            <td><%= r.getRoomType() %></td>
            <td><%= r.getCheckIn() %></td>
            <td><%= r.getCheckOut() %></td>
            <td>LKR <%= r.getTotalAmount() %></td>
            <td>
                <a class="btnMini view" href="viewReservation?reservationNo=<%= r.getReservationNo() %>">View</a>
                <a class="btnMini edit" href="editReservation?reservationNo=<%= r.getReservationNo() %>">Edit</a>

                <form class="inline" method="post" action="deleteReservation"
                      onsubmit="return confirm('Delete reservation <%= r.getReservationNo() %>?');">
                    <input type="hidden" name="reservationNo" value="<%= r.getReservationNo() %>">
                    <button class="btnMini del" type="submit">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
    </table>
    <%
        }
    %>

    <p style="margin-top:14px;"><a href="dashboard.jsp">Back to Dashboard</a></p>
</div>

</body>
</html>