package com.oceanview.service;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

public class ReservationService {

    private final ReservationDAO reservationDAO = new ReservationDAO();

    // ✅ Validate + calculate nights + total
    public Reservation buildReservation(String reservationNo, String guestName, String guestAddress,
                                        String contactNumber, String roomType,
                                        String checkInStr, String checkOutStr, String rateStr) {

        if (isBlank(reservationNo) || isBlank(guestName) || isBlank(guestAddress) ||
                isBlank(contactNumber) || isBlank(roomType) || isBlank(checkInStr) ||
                isBlank(checkOutStr) || isBlank(rateStr)) {
            throw new IllegalArgumentException("empty");
        }

        // Contact number must be exactly 10 digits
        if (!contactNumber.matches("\\d{10}")) {
            throw new IllegalArgumentException("contact");
        }

        LocalDate checkIn = LocalDate.parse(checkInStr);
        LocalDate checkOut = LocalDate.parse(checkOutStr);

        long nightsLong = ChronoUnit.DAYS.between(checkIn, checkOut);
        if (nightsLong <= 0) {
            throw new IllegalArgumentException("date");
        }

        double ratePerNight;
        try {
            ratePerNight = Double.parseDouble(rateStr);
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("rate");
        }
        if (ratePerNight < 0) {
            throw new IllegalArgumentException("rate");
        }

        int nights = (int) nightsLong;
        double totalAmount = nights * ratePerNight;

        Reservation r = new Reservation();
        r.setReservationNo(reservationNo.trim());
        r.setGuestName(guestName.trim());
        r.setGuestAddress(guestAddress.trim());
        r.setContactNumber(contactNumber.trim());
        r.setRoomType(roomType.trim());
        r.setCheckIn(checkIn);
        r.setCheckOut(checkOut);
        r.setNights(nights);
        r.setRatePerNight(ratePerNight);
        r.setTotalAmount(totalAmount);

        return r;
    }

    public boolean reservationExists(String reservationNo) throws Exception {
        return reservationDAO.existsByReservationNo(reservationNo.trim());
    }

    public void saveReservation(Reservation r) throws Exception {
        reservationDAO.insert(r);
    }

    public Reservation getReservation(String reservationNo) throws Exception {
        return reservationDAO.findByReservationNo(reservationNo.trim());
    }

    // ✅ List all
    public List<Reservation> getAllReservations() throws Exception {
        return reservationDAO.findAll();
    }

    // ✅ Filtered list (DB side)
    public List<Reservation> getFilteredReservations(String reservationNo, String guestName, String contact, String roomType) throws Exception {
        return reservationDAO.findFiltered(reservationNo, guestName, contact, roomType);
    }

    // ✅ Update
    public void updateReservation(Reservation r) throws Exception {
        reservationDAO.update(r);
    }

    // ✅ Delete
    public void deleteReservation(String reservationNo) throws Exception {
        reservationDAO.deleteByReservationNo(reservationNo.trim());
    }

    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }
}