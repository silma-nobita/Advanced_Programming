package com.oceanview.controller;

import com.oceanview.service.ReservationService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/allReservations")
public class AllReservationsServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            // Separate filters from JSP
            String reservationNo = safe(req.getParameter("reservationNo"));
            String guestName = safe(req.getParameter("guestName"));
            String contact = safe(req.getParameter("contact"));
            String roomType = safe(req.getParameter("roomType")); // "ALL" or Single/Double/Deluxe

            // Total count (all rows)
            int totalCount = reservationService.getAllReservations().size();

            // Filtered list (DB-side filtering)
            var filteredList = reservationService.getFilteredReservations(reservationNo, guestName, contact, roomType);

            // Send back values (so inputs stay filled)
            req.setAttribute("reservationNo", reservationNo);
            req.setAttribute("guestName", guestName);
            req.setAttribute("contact", contact);
            req.setAttribute("roomType", roomType);

            req.setAttribute("totalCount", totalCount);
            req.setAttribute("filteredCount", filteredList.size());
            req.setAttribute("list", filteredList);

            req.getRequestDispatcher("allReservations.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("dashboard.jsp");
        }
    }

    private String safe(String s) {
        return (s == null) ? "" : s.trim();
    }
}