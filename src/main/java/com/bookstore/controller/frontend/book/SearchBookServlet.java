package com.bookstore.controller.frontend.book;

import com.bookstore.service.BookServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "SearchBookServlet", value = "/search")
public class SearchBookServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookServices bookServices = new BookServices(request, response);
        bookServices.search();
    }

}
