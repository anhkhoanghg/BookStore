package com.bookstore.controller.frontend;

import com.bookstore.dao.CategoryDAO;
import com.bookstore.entity.Category;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;

@WebFilter(filterName = "CommonFilter", urlPatterns = "/*")
public class CommonFilter implements Filter {
    private final CategoryDAO categoryDAO;

    public CommonFilter() {
        this.categoryDAO = new CategoryDAO();
    }

    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());
        if(!path.startsWith("/admin") || path.startsWith("/admin/new_book") || path.startsWith("/admin/edit_book")){
            List<Category> categoriesList = categoryDAO.listAll();
            request.setAttribute("categoriesList", categoriesList);
        }
        chain.doFilter(request, response);


    }
}
