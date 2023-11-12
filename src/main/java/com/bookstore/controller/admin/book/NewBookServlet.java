package com.bookstore.controller.admin.book;

import com.bookstore.service.BookServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "NewBookServlet", value = "/admin/new_book")

public class NewBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookServices bookServices = new BookServices(request, response);
        bookServices.showBookNewForm();
    }

}
