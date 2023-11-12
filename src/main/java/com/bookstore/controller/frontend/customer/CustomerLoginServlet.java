package com.bookstore.controller.frontend.customer;

import com.bookstore.service.CustomerServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CustomerLoginServlet", value = "/login")
public class CustomerLoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerServices customerServices = new CustomerServices(request, response);
        customerServices.showLogin();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerServices customerServices = new CustomerServices(request, response);
        customerServices.doLogin();
    }
}
