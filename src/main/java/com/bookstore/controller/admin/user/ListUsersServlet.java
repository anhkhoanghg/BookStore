package com.bookstore.controller.admin.user;

import com.bookstore.service.UserServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ListUsersServlet", value = "/admin/list_users")
public class ListUsersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("message",null);
        UserServices userServices = new UserServices(request, response);
        userServices.listUsers();
    }

}
