package com.oceanview.controller;

import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String reservationNo = req.getParameter("reservationNo");

        if (reservationNo == null || reservationNo.trim().isEmpty()) {
            resp.sendRedirect("viewReservation.jsp");
            return;
        }

        try {
            Reservation r = reservationService.getReservation(reservationNo);

            if (r == null) {
                req.setAttribute("found", false);
                req.getRequestDispatcher("bill.jsp").forward(req, resp);
                return;
            }

            req.setAttribute("found", true);

            req.setAttribute("reservation_no", r.getReservationNo());
            req.setAttribute("guest_name", r.getGuestName());
            req.setAttribute("room_type", r.getRoomType());
            req.setAttribute("check_in", r.getCheckIn());
            req.setAttribute("check_out", r.getCheckOut());
            req.setAttribute("nights", r.getNights());
            req.setAttribute("rate_per_night", r.getRatePerNight());
            req.setAttribute("total_amount", r.getTotalAmount());

            req.getRequestDispatcher("bill.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("found", false);
            try {
                req.getRequestDispatcher("bill.jsp").forward(req, resp);
            } catch (Exception ex) {
                resp.sendRedirect("viewReservation.jsp");
            }
        }
    }
}