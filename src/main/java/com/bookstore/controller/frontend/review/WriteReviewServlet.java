package com.bookstore.controller.frontend.review;

import com.bookstore.service.BookServices;
import com.bookstore.service.ReviewServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "WriteReviewServlet", value = "/write_review")
public class WriteReviewServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookServices bookServices = new BookServices(request, response);
        bookServices.viewBookDetail();
    }


}
