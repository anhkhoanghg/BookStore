package com.bookstore.controller.frontend.customer;

import com.bookstore.service.CommonUtitlity;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ShowResgisterCustomerFormServlet", value = "/register")
public class ShowCustomerResgisterFormServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommonUtitlity.forwardToPage("/frontend/customer/register_form.jsp", request, response);
    }
}
