package com.bookstore.controller.admin.order;

import com.bookstore.service.BookOrderServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "UpdateOrderServlet", value = "/admin/update_order")
public class UpdateOrderServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookOrderServices bookOrderServices = new BookOrderServices(request, response);
        bookOrderServices.updateOrder();
        bookOrderServices.listOrders();
    }
}
