package com.bookstore.controller.admin;


import com.bookstore.service.UserServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AdminLoginServlet", value = "/admin/login")
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String loginPage = "/admin/login.jsp";
        RequestDispatcher dispatcher = request.getRequestDispatcher(loginPage);
        dispatcher.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserServices userServices = new UserServices(request, response);
        userServices.login();
    }
}
