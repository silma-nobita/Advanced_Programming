package com.oceanview.dao;

import com.oceanview.db.DB;
import com.oceanview.model.Reservation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {

    public boolean existsByReservationNo(String reservationNo) throws Exception {
        String sql = "SELECT reservation_no FROM reservations WHERE reservation_no = ?";

        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNo);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    public void insert(Reservation r) throws Exception {
        String insertSql = "INSERT INTO reservations " +
                "(reservation_no, guest_name, guest_address, contact_number, room_type, check_in, check_out, nights, rate_per_night, total_amount) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(insertSql)) {

            ps.setString(1, r.getReservationNo());
            ps.setString(2, r.getGuestName());
            ps.setString(3, r.getGuestAddress());
            ps.setString(4, r.getContactNumber());
            ps.setString(5, r.getRoomType());
            ps.setDate(6, java.sql.Date.valueOf(r.getCheckIn()));
            ps.setDate(7, java.sql.Date.valueOf(r.getCheckOut()));
            ps.setInt(8, r.getNights());
            ps.setDouble(9, r.getRatePerNight());
            ps.setDouble(10, r.getTotalAmount());

            ps.executeUpdate();
        }
    }

    public Reservation findByReservationNo(String reservationNo) throws Exception {
        String sql = "SELECT * FROM reservations WHERE reservation_no = ?";

        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNo);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;
                return map(rs);
            }
        }
    }

    // ✅ List all reservations
    public List<Reservation> findAll() throws Exception {
        String sql = "SELECT * FROM reservations ORDER BY created_at DESC";

        List<Reservation> list = new ArrayList<>();

        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(map(rs));
            }
        }
        return list;
    }

    // ✅ DB-side filtering (Reservation No / Guest Name / Contact / Room Type)
    public List<Reservation> findFiltered(String reservationNo, String guestName, String contact, String roomType) throws Exception {

        StringBuilder sql = new StringBuilder("SELECT * FROM reservations WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (reservationNo != null && !reservationNo.trim().isEmpty()) {
            sql.append(" AND reservation_no LIKE ?");
            params.add("%" + reservationNo.trim() + "%");
        }

        if (guestName != null && !guestName.trim().isEmpty()) {
            sql.append(" AND guest_name LIKE ?");
            params.add("%" + guestName.trim() + "%");
        }

        if (contact != null && !contact.trim().isEmpty()) {
            sql.append(" AND contact_number LIKE ?");
            params.add("%" + contact.trim() + "%");
        }

        if (roomType != null && !roomType.trim().isEmpty() && !"ALL".equalsIgnoreCase(roomType.trim())) {
            sql.append(" AND room_type = ?");
            params.add(roomType.trim());
        }

        sql.append(" ORDER BY created_at DESC");

        List<Reservation> list = new ArrayList<>();

        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(map(rs));
                }
            }
        }

        return list;
    }

    // ✅ Update reservation (use service to recalculate nights/total first)
    public void update(Reservation r) throws Exception {
        String sql = "UPDATE reservations SET " +
                "guest_name=?, guest_address=?, contact_number=?, room_type=?, " +
                "check_in=?, check_out=?, nights=?, rate_per_night=?, total_amount=? " +
                "WHERE reservation_no=?";

        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, r.getGuestName());
            ps.setString(2, r.getGuestAddress());
            ps.setString(3, r.getContactNumber());
            ps.setString(4, r.getRoomType());
            ps.setDate(5, java.sql.Date.valueOf(r.getCheckIn()));
            ps.setDate(6, java.sql.Date.valueOf(r.getCheckOut()));
            ps.setInt(7, r.getNights());
            ps.setDouble(8, r.getRatePerNight());
            ps.setDouble(9, r.getTotalAmount());
            ps.setString(10, r.getReservationNo());

            ps.executeUpdate();
        }
    }

    // ✅ Delete reservation
    public void deleteByReservationNo(String reservationNo) throws Exception {
        String sql = "DELETE FROM reservations WHERE reservation_no = ?";

        try (Connection con = DB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, reservationNo);
            ps.executeUpdate();
        }
    }

    // helper mapper
    private Reservation map(ResultSet rs) throws Exception {
        Reservation r = new Reservation();
        r.setReservationNo(rs.getString("reservation_no"));
        r.setGuestName(rs.getString("guest_name"));
        r.setGuestAddress(rs.getString("guest_address"));
        r.setContactNumber(rs.getString("contact_number"));
        r.setRoomType(rs.getString("room_type"));
        r.setCheckIn(rs.getDate("check_in").toLocalDate());
        r.setCheckOut(rs.getDate("check_out").toLocalDate());
        r.setNights(rs.getInt("nights"));
        r.setRatePerNight(rs.getDouble("rate_per_night"));
        r.setTotalAmount(rs.getDouble("total_amount"));
        return r;
    }
}