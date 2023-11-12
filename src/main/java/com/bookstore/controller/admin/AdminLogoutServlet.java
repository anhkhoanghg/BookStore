package com.bookstore.controller.admin;

import com.bookstore.service.CommonUtitlity;
import com.bookstore.store.Message;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AdminLogoutServlet", value = "/admin/logout")
public class AdminLogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("userEmail");

        Message message = new Message("Logout successful", "Account already logout", "success");
        CommonUtitlity.forwardToPage("/frontend/index.jsp", message, request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
