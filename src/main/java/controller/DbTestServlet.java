package com.oceanview.controller;

import com.oceanview.db.DB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/dbtest")
public class DbTestServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("text/plain");

        try (Connection con = DB.getConnection()) {
            resp.getWriter().println("DB CONNECTED ✅");
            resp.getWriter().println("Database: " + con.getCatalog());
        } catch (Exception e) {
            resp.getWriter().println("DB FAILED ❌");
            e.printStackTrace(resp.getWriter());
        }
    }
}