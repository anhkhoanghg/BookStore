package com.bookstore.controller.frontend.customer;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CustomerLogoutServlet", value = "/logout")
public class CustomerLogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().removeAttribute("loggedCustomer");
        response.sendRedirect("/");
    }

}
