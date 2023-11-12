package com.bookstore.service;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO;
import com.bookstore.entity.Category;
import com.bookstore.store.Message;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class CategoryServices {

    private CategoryDAO categoryDAO;
    private BookDAO bookDAO;
    private HttpServletRequest request;
    private HttpServletResponse response;

    public CategoryServices( HttpServletRequest request, HttpServletResponse response){

        categoryDAO = new CategoryDAO();
        bookDAO = new BookDAO();
        this.request = request;
        this.response = response;
    }

    public void listCategories() throws ServletException, IOException {
        List<Category> categoriesList = categoryDAO.listAll();

        request.setAttribute("categoriesList", categoriesList);
        CommonUtitlity.forwardToPage("/admin/categories/categories_list.jsp", request, response);
    }

    public void editCategory() throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("id"));
        Category category = categoryDAO.get(categoryId);

        if(category == null){
            Message message = new Message("Category not found", "Could not find category with ID " + categoryId,"error");
            List<Category> categoriesList = categoryDAO.listAll();
            request.setAttribute("categoriesList", categoriesList);
            CommonUtitlity.forwardToPage("/admin/categories/categories_list.jsp", message, request, response);
        }else {
            request.setAttribute("category", category);
            CommonUtitlity.forwardToPage("/admin/categories/category_form.jsp", request, response);
        }
    }

    public void createCategory() throws ServletException, IOException {
        String name = request.getParameter("name");
        Category existCategory = categoryDAO.findByName(name);
        if(existCategory != null){
            Message message = new Message("Could not create category", "A name with name " +name +" already exist","error");
            Category category = new Category(name);
            request.setAttribute("category", category);

            CommonUtitlity.forwardToPage("/admin/categories/category_form.jsp", message, request, response);
        }else {
            Category newCategory = new Category(name);
            categoryDAO.create(newCategory);

            Message message = new Message("Create successful", "Create category successful", "success");
            request.setAttribute("message", message);
        }
    }

    public void updateCategory() throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String name = request.getParameter("name");
        Category existCategory = categoryDAO.findByName(name);
        if(existCategory != null && existCategory.getCategoryId() != categoryId){
            Message message = new Message("Could not update category", "A category with email " +name +" already exist","error");

            Category category = new Category();
            request.setAttribute("category", category);

            CommonUtitlity.forwardToPage("/admin/categories/category_form.jsp", message, request, response);
        }else {
            Category category = new Category(categoryId, name);
            categoryDAO.update(category);
            Message message = new Message("Update successful", "Update category successful",
                    "success");
            request.setAttribute("message", message);
        }
    }

    public void deleteCategory() {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Category category = categoryDAO.get(categoryId);

        if(category == null){
            Message message = new Message("Could not delete category", "Could not find category with Id "+
                    categoryId, "error");
            request.setAttribute("message", message);
        }else {
            bookDAO = new BookDAO();
            long numberOfBooks = bookDAO.countByCategory(categoryId);
            if(numberOfBooks > 0){
                Message message = new Message("Delete failure", "Could not delete category (ID: " + categoryId
                        + " ) because it currently contains some book", "error");
                request.setAttribute("message", message);
            } else {
                categoryDAO.delete(categoryId);
                Message message = new Message("Delete successful", "Delete category successful", "success");
                request.setAttribute("message", message);
            }

        }
    }
}
