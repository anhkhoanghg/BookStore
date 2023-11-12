package com.bookstore.controller.admin.customer;

import com.bookstore.service.CustomerServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteCustomerServlet", value = "/admin/delete_customer")
public class DeleteCustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerServices customerServices = new CustomerServices(request, response);
        customerServices.deleteCustomer();
        customerServices.listCustomers();
    }
}
