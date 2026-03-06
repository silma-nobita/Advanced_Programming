package com.oceanview.controller;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/helpSearch")
public class HelpSearchServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        String q = req.getParameter("q");
        if (q == null) q = "";
        String query = q.trim().toLowerCase();

        String answer;

        if (query.contains("add") && query.contains("reservation")) {
            answer = "Go to Dashboard → Add Reservation. Fill Reservation No, Guest details, Room Type, Check-in/Check-out dates, Rate per Night, then click Save.";
        } else if (query.contains("view") && query.contains("reservation")) {
            answer = "Go to Dashboard → View Reservation. Enter the reservation number (example: R001) and click Search to view details.";
        } else if (query.contains("bill") || query.contains("print")) {
            answer = "Go to View Reservation, search the reservation number, then click Print Bill. On the invoice page, click the Print button.";
        } else if (query.contains("logout") || query.contains("sign out")) {
            answer = "From Dashboard, click Logout. You will return to the login page and your session will end.";
        } else if (query.contains("login") || query.contains("sign in")) {
            answer = "Open login page and enter username and password. Example test: admin / admin123.";
        } else {
            answer = "Sorry, I couldn't find an exact match. Try keywords like: add reservation, view reservation, print bill, logout, login.";
        }

        req.setAttribute("q", q);
        req.setAttribute("answer", answer);

        try {
            req.getRequestDispatcher("help.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendRedirect("help.jsp");
        }
    }
}