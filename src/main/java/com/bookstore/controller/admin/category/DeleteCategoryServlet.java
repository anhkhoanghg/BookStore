package com.bookstore.controller.admin.category;

import com.bookstore.service.CategoryServices;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "DeleteCategoryServlet", value = "/admin/delete_category")
public class DeleteCategoryServlet extends HttpServlet {


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryServices categoryServices = new CategoryServices(request, response);
        categoryServices.deleteCategory();
        categoryServices.listCategories();
    }
}
