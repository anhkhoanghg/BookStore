package com.bookstore.controller.frontend.vnpay;

import com.bookstore.service.CommonUtitlity;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ReviewVnpayPaymentServlet", value = "/review_vnpay_payment")
public class ReviewVnpayPaymentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommonUtitlity.forwardToPage("/frontend/order/vnpay/review_payment.jsp", request, response);
    }
}
