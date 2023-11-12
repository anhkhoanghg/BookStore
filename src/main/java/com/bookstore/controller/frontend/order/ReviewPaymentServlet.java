package com.bookstore.controller.frontend.order;



import com.bookstore.service.PaymentServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ReviewPaymentServlet", value = "/review_payment")
public class ReviewPaymentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PaymentServices paymentServices = new PaymentServices(request, response);
        paymentServices.reviewPayment();
    }
}
