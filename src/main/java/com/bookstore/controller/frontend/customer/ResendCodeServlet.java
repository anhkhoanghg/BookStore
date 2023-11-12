package com.bookstore.controller.frontend.customer;

import com.bookstore.entity.Customer;
import com.bookstore.service.EmailServices;

import javax.mail.MessagingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ResendCodeServlet", value = "/resend_code")
public class ResendCodeServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        String code = EmailServices.getRandom();
        customer.setCode(code);

        try {
            EmailServices.sendEmail("smtp.gmail.com", "587", "phichh16@gmail.com", "knkatubzsdmcrnps",
                    customer.getEmail(), "Email Verification",
                    "<p>Registered successfully.Please verify your account using this code: " + customer.getCode() + "</p>") ;
            session.setAttribute("customer", customer);
            response.sendRedirect("/verify");
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
