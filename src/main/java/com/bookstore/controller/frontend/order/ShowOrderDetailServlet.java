package com.bookstore.controller.frontend.order;

import com.bookstore.service.BookOrderServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ShowOrderDetailServlet", value = "/show_order_detail")
public class ShowOrderDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookOrderServices bookOrderServices = new BookOrderServices(request, response);
        bookOrderServices.showOrderDetailForCustomer();
    }
}
