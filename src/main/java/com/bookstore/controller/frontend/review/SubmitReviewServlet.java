package com.bookstore.controller.frontend.review;

import com.bookstore.service.ReviewServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "SubmitReviewServlet", value = "/submit_review")
public class SubmitReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReviewServices reviewServices = new ReviewServices(request, response);
        reviewServices.submitReview();
    }
}
