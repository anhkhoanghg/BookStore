package com.bookstore.controller.admin.order;

import com.bookstore.service.BookOrderServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ViewOrderDetailServlet", value = "/admin/view_order")
public class ViewOrderDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        BookOrderServices bookOrderServices = new BookOrderServices(request, response);
        bookOrderServices.viewOrderDetailForAdmin();
    }
}
