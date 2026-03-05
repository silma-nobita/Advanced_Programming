<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  if (session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
  }
  String m = request.getParameter("msg");
%>
<html>
<head>
  <title>Add Reservation</title>
  <style>
    body{font-family:Arial,sans-serif;background:#f5f6fa;margin:0;padding:20px}
    .box{max-width:850px;margin:0 auto;background:#fff;padding:18px 20px;border:1px solid #e5e7eb;border-radius:10px}
    label{font-weight:700;font-size:14px}
    input, textarea, select{
      width:100%;
      padding:10px;
      margin-top:6px;
      border:1px solid #cbd5e1;
      border-radius:8px;
      outline:none;
      box-sizing:border-box;
    }
    input:focus, textarea:focus, select:focus{
      border-color:#2563eb;
      box-shadow:0 0 0 3px rgba(37,99,235,0.15);
    }
    .row{display:grid;grid-template-columns:1fr 1fr;gap:12px}
    .btn{
      background:#2563eb;color:#fff;border:none;border-radius:8px;
      padding:10px 14px;font-weight:800;cursor:pointer
    }
    .btn:hover{opacity:0.95}
    .msg{margin-top:12px;padding:10px;border-radius:8px;font-size:14px}
    .ok{background:#dcfce7;color:#166534;border:1px solid #bbf7d0}
    .bad{background:#fee2e2;color:#991b1b;border:1px solid #fecaca}
    .muted{color:#64748b}
  </style>
</head>
<body>

<div class="box">
  <h2>Add New Reservation</h2>
  <p class="muted">Fill all fields and click Save Reservation.</p>

  <form method="post" action="addReservation">

    <div class="row">
      <div>
        <label>Reservation No</label>
        <input type="text" name="reservationNo" required placeholder="Example: R001">
      </div>

      <div>
        <label>Room Type</label>
        <select name="roomType" required>
          <option value="">-- Select --</option>
          <option value="Single">Single</option>
          <option value="Double">Double</option>
          <option value="Deluxe">Deluxe</option>
        </select>
      </div>
    </div>

    <div style="height:10px;"></div>

    <label>Guest Name</label>
    <input type="text" name="guestName" required placeholder="Example: Nimal Perera">

    <div style="height:10px;"></div>

    <label>Guest Address</label>
    <textarea name="guestAddress" rows="3" required placeholder="Example: Colombo, Sri Lanka"></textarea>

    <div style="height:10px;"></div>

    <label>Contact Number (10 digits)</label>
    <input type="text"
           name="contactNumber"
           required
           minlength="10"
           maxlength="10"
           pattern="\d{10}"
           title="Contact number must be exactly 10 digits (numbers only)"
           placeholder="Example: 0771234567">

    <div style="height:10px;"></div>

    <div class="row">
      <div>
        <label>Check-in Date</label>
        <input type="date" name="checkIn" required>
      </div>

      <div>
        <label>Check-out Date</label>
        <input type="date" name="checkOut" required>
      </div>
    </div>

    <div style="height:10px;"></div>

    <label>Rate per Night (LKR)</label>
    <input type="number" step="0.01" min="0" name="ratePerNight" required placeholder="Example: 5000">

    <div style="height:14px;"></div>

    <button class="btn" type="submit">Save Reservation</button>
  </form>

  <%-- Messages --%>
  <%
    if ("saved".equals(m)) {
  %>
  <div class="msg ok">Reservation saved ✅</div>
  <%
  } else if ("exists".equals(m)) {
  %>
  <div class="msg bad">Reservation number already exists ❌</div>
  <%
  } else if ("contact".equals(m)) {
  %>
  <div class="msg bad">Contact number must be exactly 10 digits ❌</div>
  <%
  } else if ("date".equals(m)) {
  %>
  <div class="msg bad">Check-out date must be after check-in date ❌</div>
  <%
  } else if ("error".equals(m)) {
  %>
  <div class="msg bad">Something went wrong ❌</div>
  <%
    }
  %>

  <div style="margin-top:14px;">
    <a href="dashboard.jsp">Back to Dashboard</a>
  </div>
</div>

</body>
</html>

