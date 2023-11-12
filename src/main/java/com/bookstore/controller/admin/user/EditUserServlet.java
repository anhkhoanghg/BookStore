package com.bookstore.controller.admin.user;

import com.bookstore.service.UserServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "EditUserServlet", value = "/admin/edit_user")
public class EditUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserServices userServices = new UserServices(request, response);
        userServices.editUser();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserServices userServices = new UserServices(request, response);
        userServices.updateUser();
        userServices.listUsers();

    }
}
