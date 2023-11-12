package com.bookstore.controller.admin.category;

import com.bookstore.service.CategoryServices;
import com.bookstore.service.CommonUtitlity;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "CreateCategoryServlet", value = "/admin/create_category")
public class CreateCategoryServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CommonUtitlity.forwardToPage("/admin/categories/category_form.jsp", request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CategoryServices categoryServices = new CategoryServices(request, response);
        categoryServices.createCategory();
        categoryServices.listCategories();
    }
}
