package com.oceanview.controller;

import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/viewReservation")
public class ViewReservationServlet extends HttpServlet {

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
                resp.sendRedirect("viewReservation.jsp?msg=notfound");
                return;
            }

            req.setAttribute("found", true);

            req.setAttribute("reservation_no", r.getReservationNo());
            req.setAttribute("guest_name", r.getGuestName());
            req.setAttribute("guest_address", r.getGuestAddress());
            req.setAttribute("contact_number", r.getContactNumber());
            req.setAttribute("room_type", r.getRoomType());
            req.setAttribute("check_in", r.getCheckIn());
            req.setAttribute("check_out", r.getCheckOut());
            req.setAttribute("nights", r.getNights());
            req.setAttribute("rate_per_night", r.getRatePerNight());
            req.setAttribute("total_amount", r.getTotalAmount());

            req.getRequestDispatcher("viewReservation.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("viewReservation.jsp?msg=notfound");
        }
    }
}