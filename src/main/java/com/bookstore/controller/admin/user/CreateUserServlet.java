package com.bookstore.controller.admin.user;

import com.bookstore.service.UserServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CreateUserServlet", value = "/admin/create_user")
public class CreateUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String createUserPage ="/admin/users/user_form.jsp";
        RequestDispatcher requestDispatcher = request.getRequestDispatcher(createUserPage);
        requestDispatcher.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        UserServices userServices = new UserServices(request, response);
        userServices.createUser();
        userServices.listUsers();
    }
}
