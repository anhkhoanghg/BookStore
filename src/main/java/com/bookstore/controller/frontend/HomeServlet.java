package com.bookstore.controller.frontend;

import com.bookstore.dao.BookDAO;
import com.bookstore.entity.Book;
import com.bookstore.service.CommonUtitlity;
import com.bookstore.store.Message;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HomeServlet", value = "")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Message message = (Message) session.getAttribute("message");
        request.setAttribute("message", message);
        session.removeAttribute("message");

        BookDAO bookDAO = new BookDAO();
        List<Book> listNewBooks = bookDAO.listNewBooks();
        List<Book> listBestSellingBooks = bookDAO.listBestSellingBooks();
        List<Book> listMostFavoredBooks = bookDAO.listMostFavoredBooks();

        request.setAttribute("listNewBooks",listNewBooks);
        request.setAttribute("listBestSellingBooks", listBestSellingBooks);
        request.setAttribute("listMostFavoredBooks", listMostFavoredBooks);

        CommonUtitlity.forwardToPage("/frontend/index.jsp", request, response);
    }

}
