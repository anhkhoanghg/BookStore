package com.bookstore.controller.frontend.shoppingcart;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ClearCartServlet", value = "/clear_cart")
public class ClearCartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ShoppingCart cart = (ShoppingCart) request.getSession().getAttribute("cart");
        cart.clear();

        String cartPage = request.getContextPath().concat("/view_cart");
        response.sendRedirect(cartPage);
    }

}
