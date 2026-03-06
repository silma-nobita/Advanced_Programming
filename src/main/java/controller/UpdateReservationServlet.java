package com.oceanview.controller;

import com.oceanview.model.Reservation;
import com.oceanview.service.ReservationService;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/updateReservation")
public class UpdateReservationServlet extends HttpServlet {

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
            Reservation r = reservationService.buildReservation(
                    reservationNo, guestName, guestAddress, contactNumber,
                    roomType, checkInStr, checkOutStr, rateStr
            );

            reservationService.updateReservation(r);
            resp.sendRedirect("editReservation?reservationNo=" + reservationNo + "&msg=saved");

        } catch (IllegalArgumentException iae) {
            String code = iae.getMessage();
            if ("contact".equals(code)) {
                resp.sendRedirect("editReservation?reservationNo=" + reservationNo + "&msg=contact");
            } else if ("date".equals(code)) {
                resp.sendRedirect("editReservation?reservationNo=" + reservationNo + "&msg=date");
            } else {
                resp.sendRedirect("editReservation?reservationNo=" + reservationNo + "&msg=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("editReservation?reservationNo=" + reservationNo + "&msg=error");
        }
    }
}