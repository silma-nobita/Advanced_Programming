<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
  }

  com.oceanview.model.Reservation r =
          (com.oceanview.model.Reservation) request.getAttribute("r");

  if (r == null) {
    response.sendRedirect("allReservations");
    return;
  }

  String m = request.getParameter("msg"); // saved/contact/date/error
%>
<html>
<head>
  <title>Edit Reservation</title>
  <style>
    body{font-family:Arial,sans-serif;background:#f5f6fa;margin:0;padding:20px}
    .wrap{max-width:900px;margin:0 auto}
    .card{
      background:#fff;border:1px solid #e5e7eb;border-radius:12px;
      padding:18px 20px;box-shadow:0 8px 18px rgba(0,0,0,0.06)
    }
    h2{margin:0 0 6px 0}
    .muted{color:#64748b;margin:0 0 14px 0}
    .divider{height:1px;background:#e5e7eb;margin:16px 0}
    .grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
    label{font-weight:800;font-size:13px;color:#0f172a}
    input, textarea, select{
      width:100%;padding:10px;margin-top:6px;border:1px solid #cbd5e1;
      border-radius:10px;outline:none;box-sizing:border-box;background:#fff
    }
    textarea{resize:vertical}
    input:focus, textarea:focus, select:focus{
      border-color:#2563eb;box-shadow:0 0 0 3px rgba(37,99,235,0.15)
    }
    input[readonly]{
      background:#f1f5f9;color:#334155;font-weight:700;
    }
    .msg{margin-top:12px;padding:10px;border-radius:10px;font-size:14px}
    .ok{background:#dcfce7;color:#166534;border:1px solid #bbf7d0}
    .bad{background:#fee2e2;color:#991b1b;border:1px solid #fecaca}
    .actions{display:flex;gap:10px;flex-wrap:wrap;margin-top:14px}
    button,a.btn{
      padding:10px 14px;border:none;border-radius:10px;font-weight:800;
      cursor:pointer;text-decoration:none;display:inline-block
    }
    button{background:#2563eb;color:#fff}
    button:hover{opacity:0.95}
    a.btn{background:#0f172a;color:#fff}
    a.btn:hover{opacity:0.95}

    @media(max-width:700px){
      .grid{grid-template-columns:1fr;}
    }
  </style>
</head>
<body>

<div class="wrap">
  <div class="card">
    <h2>Edit Reservation</h2>
    <p class="muted">Update details and click <b>Save Changes</b>. Reservation number cannot be changed.</p>

    <%-- Messages --%>
    <% if ("saved".equals(m)) { %>
    <div class="msg ok">Updated successfully ✅</div>
    <% } else if ("contact".equals(m)) { %>
    <div class="msg bad">Contact number must be exactly 10 digits ❌</div>
    <% } else if ("date".equals(m)) { %>
    <div class="msg bad">Check-out date must be after check-in date ❌</div>
    <% } else if ("error".equals(m)) { %>
    <div class="msg bad">Something went wrong ❌</div>
    <% } %>

    <div class="divider"></div>

    <form method="post" action="updateReservation">
      <div class="grid">
        <div>
          <label>Reservation No (read-only)</label>
          <input type="text" name="reservationNo" value="<%= r.getReservationNo() %>" readonly>
        </div>

        <div>
          <label>Room Type</label>
          <select name="roomType" required>
            <option value="Single" <%= "Single".equalsIgnoreCase(r.getRoomType()) ? "selected" : "" %>>Single</option>
            <option value="Double" <%= "Double".equalsIgnoreCase(r.getRoomType()) ? "selected" : "" %>>Double</option>
            <option value="Deluxe" <%= "Deluxe".equalsIgnoreCase(r.getRoomType()) ? "selected" : "" %>>Deluxe</option>
          </select>
        </div>

        <div>
          <label>Guest Name</label>
          <input type="text" name="guestName" value="<%= r.getGuestName() %>" required>
        </div>

        <div>
          <label>Contact Number (10 digits)</label>
          <input type="text"
                 name="contactNumber"
                 value="<%= r.getContactNumber() %>"
                 required minlength="10" maxlength="10"
                 pattern="\\d{10}"
                 title="Contact number must be exactly 10 digits (numbers only)">
        </div>
      </div>

      <div style="height:12px;"></div>

      <label>Guest Address</label>
      <textarea name="guestAddress" rows="3" required><%= r.getGuestAddress() %></textarea>

      <div style="height:12px;"></div>

      <div class="grid">
        <div>
          <label>Check-in Date</label>
          <input type="date" name="checkIn" value="<%= r.getCheckIn() %>" required>
        </div>
        <div>
          <label>Check-out Date</label>
          <input type="date" name="checkOut" value="<%= r.getCheckOut() %>" required>
        </div>
      </div>

      <div style="height:12px;"></div>

      <div class="grid">
        <div>
          <label>Rate per Night (LKR)</label>
          <input type="number" step="0.01" min="0" name="ratePerNight" value="<%= r.getRatePerNight() %>" required>
        </div>
        <div></div>
      </div>

      <div class="actions">
        <button type="submit">Save Changes</button>
        <a class="btn" href="allReservations">Back to All Reservations</a>
      </div>
    </form>

  </div>
</div>

</body>
</html>