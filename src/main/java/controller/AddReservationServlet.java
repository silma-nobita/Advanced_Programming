package com.oceanview.controller;

import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/addReservation")
public class AddReservationServlet extends HttpServlet {

    private final ReservationService reservationService = new ReservationService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String reservationNo = req.getParameter("reservationNo");
        String guestName = req.getParameter("guestName");
        String guestAddress = req.getParameter("guestAddress");
        String contactNumber = req.getParameter("contactNumber");
        String roomType = req.getParameter("roomType");
        String checkInStr = req.getParameter("checkIn");
        String checkOutStr = req.getParameter("checkOut");
        String rateStr = req.getParameter("ratePerNight");

        try {
            // ✅ validate + calculate nights + total (done in service)
            Reservation r = reservationService.buildReservation(
                    reservationNo, guestName, guestAddress, contactNumber,
                    roomType, checkInStr, checkOutStr, rateStr
            );

            // ✅ check duplicate reservation number
            if (reservationService.reservationExists(r.getReservationNo())) {
                resp.sendRedirect("addReservation.jsp?msg=exists");
                return;
            }

            // ✅ save
            reservationService.saveReservation(r);
            resp.sendRedirect("addReservation.jsp?msg=saved");

        } catch (IllegalArgumentException iae) {
            String code = iae.getMessage();
            if ("contact".equals(code)) {
                resp.sendRedirect("addReservation.jsp?msg=contact");
            } else if ("date".equals(code)) {
                resp.sendRedirect("addReservation.jsp?msg=date");
            } else {
                resp.sendRedirect("addReservation.jsp?msg=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("addReservation.jsp?msg=error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        // If user opens /addReservation directly, go to the form page
        resp.sendRedirect("addReservation.jsp");
    }
}