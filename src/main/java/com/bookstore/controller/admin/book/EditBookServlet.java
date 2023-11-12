package com.bookstore.controller.admin.book;

import com.bookstore.service.BookServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "EditBookServlet", value = "/admin/edit_book")
@MultipartConfig(
        fileSizeThreshold = 1024 * 10,
        maxFileSize = 1024 * 300,
        maxRequestSize = 1024 * 1024
)
public class EditBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookServices bookServices = new BookServices(request, response);
        bookServices.editBook();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookServices bookServices = new BookServices( request, response);
        bookServices.updateBook();
        bookServices.listBooks();
    }
}
