package com.oceanview.controller;

import com.oceanview.service.ReservationService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteReservation")
public class DeleteReservationServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String reservationNo = req.getParameter("reservationNo");
        if (reservationNo == null || reservationNo.trim().isEmpty()) {
            resp.sendRedirect("allReservations");
            return;
        }

        try {
            reservationService.deleteReservation(reservationNo);
        } catch (Exception e) {
            e.printStackTrace();
        }
        resp.sendRedirect("allReservations");
    }
}