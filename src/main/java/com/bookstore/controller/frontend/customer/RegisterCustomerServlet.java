package com.bookstore.controller.frontend.customer;

import com.bookstore.service.CustomerServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RegisterCustomerServlet", value = "/register_account")
public class RegisterCustomerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerServices customerServices = new CustomerServices(request, response);
        customerServices.registerCustomer("smtp.gmail.com", "587", "phichh16@gmail.com", "knkatubzsdmcrnps");
    }
}
