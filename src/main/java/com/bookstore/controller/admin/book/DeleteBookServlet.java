package com.bookstore.controller.admin.book;

import com.bookstore.service.BookServices;


import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteBookServlet", value = "/admin/delete_book")
public class DeleteBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookServices bookServices = new BookServices(request, response);
        bookServices.deleteBook();
        bookServices.listBooks();
    }
}
