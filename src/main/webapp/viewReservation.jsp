<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Object found = request.getAttribute("found");
    String msg = request.getParameter("msg");
%>
<html>
<head>
    <title>View Reservation</title>
    <style>
        body{font-family:Arial,sans-serif;background:#f5f6fa;margin:0;padding:20px}
        .wrap{max-width:900px;margin:0 auto}
        .card{
            background:#fff;
            border:1px solid #e5e7eb;
            border-radius:12px;
            padding:18px 20px;
            box-shadow:0 8px 18px rgba(0,0,0,0.06);
        }
        h2{margin:0 0 8px 0}
        .muted{color:#64748b;margin:0 0 14px 0}
        .row{display:flex;gap:10px;align-items:center;flex-wrap:wrap}
        input{
            padding:10px;
            border:1px solid #cbd5e1;
            border-radius:10px;
            outline:none;
            min-width:260px;
        }
        input:focus{
            border-color:#2563eb;
            box-shadow:0 0 0 3px rgba(37,99,235,0.15);
        }
        button{
            padding:10px 14px;
            border:none;
            border-radius:10px;
            background:#2563eb;
            color:#fff;
            font-weight:800;
            cursor:pointer;
        }
        button:hover{opacity:0.95}
        .divider{height:1px;background:#e5e7eb;margin:16px 0}
        .msg{padding:10px;border-radius:10px;font-size:14px;margin-top:12px}
        .bad{background:#fee2e2;color:#991b1b;border:1px solid #fecaca}
        .ok{background:#dcfce7;color:#166534;border:1px solid #bbf7d0}
        .grid{
            display:grid;
            grid-template-columns: 1fr 1fr;
            gap:10px 16px;
        }
        .field{
            background:#fafafa;
            border:1px solid #e5e7eb;
            border-radius:10px;
            padding:10px 12px;
        }
        .label{color:#64748b;font-size:12px;margin-bottom:4px}
        .val{font-weight:800;color:#0f172a}
        .actions{display:flex;gap:10px;flex-wrap:wrap;margin-top:14px}
        a.btn{
            display:inline-block;
            padding:10px 14px;
            border-radius:10px;
            font-weight:800;
            text-decoration:none;
            color:#fff;
            background:#0f172a;
        }
        a.btn:hover{opacity:0.95}
        a.btn2{
            background:#2563eb;
        }
        @media(max-width:700px){
            .grid{grid-template-columns:1fr;}
            input{min-width:100%;}
        }
    </style>
</head>
<body>

<div class="wrap">
    <div class="card">
        <h2>View Reservation</h2>
        <p class="muted">Search using reservation number (example: R001).</p>

        <form method="get" action="viewReservation">
            <div class="row">
                <input type="text" name="reservationNo" placeholder="Enter Reservation No" required>
                <button type="submit">Search</button>
            </div>
        </form>

        <% if ("notfound".equals(msg)) { %>
        <div class="msg bad">Reservation not found ❌</div>
        <% } %>

        <div class="divider"></div>

        <%
            if (found != null && (boolean) found) {
        %>
        <h3 style="margin:0 0 10px 0;">Reservation Details ✅</h3>

        <div class="grid">
            <div class="field">
                <div class="label">Reservation No</div>
                <div class="val"><%= request.getAttribute("reservation_no") %></div>
            </div>
            <div class="field">
                <div class="label">Guest Name</div>
                <div class="val"><%= request.getAttribute("guest_name") %></div>
            </div>

            <div class="field">
                <div class="label">Address</div>
                <div class="val"><%= request.getAttribute("guest_address") %></div>
            </div>
            <div class="field">
                <div class="label">Contact</div>
                <div class="val"><%= request.getAttribute("contact_number") %></div>
            </div>

            <div class="field">
                <div class="label">Room Type</div>
                <div class="val"><%= request.getAttribute("room_type") %></div>
            </div>
            <div class="field">
                <div class="label">Nights</div>
                <div class="val"><%= request.getAttribute("nights") %></div>
            </div>

            <div class="field">
                <div class="label">Check-in</div>
                <div class="val"><%= request.getAttribute("check_in") %></div>
            </div>
            <div class="field">
                <div class="label">Check-out</div>
                <div class="val"><%= request.getAttribute("check_out") %></div>
            </div>

            <div class="field">
                <div class="label">Rate per Night</div>
                <div class="val">LKR <%= request.getAttribute("rate_per_night") %></div>
            </div>
            <div class="field">
                <div class="label">Total Amount</div>
                <div class="val">LKR <%= request.getAttribute("total_amount") %></div>
            </div>
        </div>

        <div class="actions">
            <a class="btn btn2" href="bill?reservationNo=<%= request.getAttribute("reservation_no") %>">Print Bill</a>
            <a class="btn" href="dashboard.jsp">Back to Dashboard</a>
        </div>
        <%
        } else {
        %>
        <p class="muted">No results yet. Search a reservation number above.</p>
        <div class="actions">
            <a class="btn" href="dashboard.jsp">Back to Dashboard</a>
        </div>
        <%
            }
        %>

    </div>
</div>

</body>
</html>