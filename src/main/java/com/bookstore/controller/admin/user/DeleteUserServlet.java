package com.bookstore.controller.admin.user;

import com.bookstore.service.UserServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteUserServlet", value = "/admin/delete_user")
public class DeleteUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserServices userServices = new UserServices(request, response);
        userServices.deleteUser();
        userServices.listUsers();
    }
}
