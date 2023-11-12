package com.bookstore.controller.frontend.shoppingcart;

import com.bookstore.dao.BookDAO;
import com.bookstore.entity.Book;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "RemoveBookFromCartServlet", value = "/remove_from_cart")
public class RemoveBookFromCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("book_id"));
        Object cartObject = request.getSession().getAttribute("cart");
        ShoppingCart shoppingCart =  (ShoppingCart) cartObject;

        Book book = new Book(bookId);
        shoppingCart.removeItem(book);

        String cartPage = request.getContextPath().concat("/view_cart");
        response.sendRedirect(cartPage);
    }
}
