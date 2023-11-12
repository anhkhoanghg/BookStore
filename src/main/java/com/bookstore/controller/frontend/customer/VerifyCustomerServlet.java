package com.bookstore.controller.frontend.customer;

import com.bookstore.entity.Customer;
import com.bookstore.service.CommonUtitlity;
import com.bookstore.service.CustomerServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "VerifyCustomerServlet", value = "/verify")
public class VerifyCustomerServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommonUtitlity.forwardToPage("/frontend/customer/verify.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CustomerServices customerServices = new CustomerServices(request, response);
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            Customer customer = (Customer) session.getAttribute("customer");
            String code = request.getParameter("code");
            if(code.equals(customer.getCode())){
                customerServices.saveCustomer();
                session.setAttribute("msg", "Please update your information.");
                response.sendRedirect("/profile");
            }else{
                out.println("Incorrect verification code");
            }
        }
    }
}
