package com.bookstore.controller.admin.order;

import com.bookstore.dao.BookDAO;
import com.bookstore.entity.Book;
import com.bookstore.service.CommonUtitlity;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ShowAddBookFormServlet", value = "/admin/add_book_form")
public class ShowAddBookFormServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookDAO bookDAO = new BookDAO();
        List<Book> booksList = bookDAO.listAll();
        request.setAttribute("booksList", booksList);
        CommonUtitlity.forwardToPage("/admin/orders/add_book_form.jsp", request, response);
    }
}
