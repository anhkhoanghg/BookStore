package com.bookstore.controller.admin.review;

import com.bookstore.service.ReviewServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ListReviewsServlet", value = "/admin/list_reviews")
public class ListReviewsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ReviewServices reviewServices = new ReviewServices(request, response);
        reviewServices.listReviews();
    }
}
