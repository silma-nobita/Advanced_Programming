package com.oceanview.model;

import java.time.LocalDate;

public class Reservation {

    private String reservationNo;
    private String guestName;
    private String guestAddress;
    private String contactNumber;
    private String roomType;
    private LocalDate checkIn;
    private LocalDate checkOut;
    private int nights;
    private double ratePerNight;
    private double totalAmount;

    public Reservation() {}

    public Reservation(String reservationNo, String guestName, String guestAddress, String contactNumber,
                       String roomType, LocalDate checkIn, LocalDate checkOut,
                       int nights, double ratePerNight, double totalAmount) {
        this.reservationNo = reservationNo;
        this.guestName = guestName;
        this.guestAddress = guestAddress;
        this.contactNumber = contactNumber;
        this.roomType = roomType;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.nights = nights;
        this.ratePerNight = ratePerNight;
        this.totalAmount = totalAmount;
    }

    public String getReservationNo() { return reservationNo; }
    public void setReservationNo(String reservationNo) { this.reservationNo = reservationNo; }

    public String getGuestName() { return guestName; }
    public void setGuestName(String guestName) { this.guestName = guestName; }

    public String getGuestAddress() { return guestAddress; }
    public void setGuestAddress(String guestAddress) { this.guestAddress = guestAddress; }

    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public LocalDate getCheckIn() { return checkIn; }
    public void setCheckIn(LocalDate checkIn) { this.checkIn = checkIn; }

    public LocalDate getCheckOut() { return checkOut; }
    public void setCheckOut(LocalDate checkOut) { this.checkOut = checkOut; }

    public int getNights() { return nights; }
    public void setNights(int nights) { this.nights = nights; }

    public double getRatePerNight() { return ratePerNight; }
    public void setRatePerNight(double ratePerNight) { this.ratePerNight = ratePerNight; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
}