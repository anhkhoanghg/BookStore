package com.bookstore.controller.admin.category;

import com.bookstore.service.CategoryServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "ListCategoriesServlet", value = "/admin/list_categories")
public class ListCategoriesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setAttribute("message",null);
        CategoryServices categoryServices = new CategoryServices(request,response);
        categoryServices.listCategories();
    }

}
