package com.bookstore.controller.admin.category;

import com.bookstore.service.CategoryServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "EditCategoryServlet", value = "/admin/edit_category")
public class EditCategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryServices categoryServices = new CategoryServices(request, response);
        categoryServices.editCategory();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryServices categoryServices = new CategoryServices(request, response);
        categoryServices.updateCategory();
        categoryServices.listCategories();
    }
}
