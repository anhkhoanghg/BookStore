package com.bookstore.controller.admin;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebFilter(filterName = "AdminLoginFilter", urlPatterns = "/admin/*", description = "Filter all admin URLs")
public class AdminLoginFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(false);

        boolean isLoggedin = session != null && session.getAttribute("userEmail") != null;

        String loginURI = httpRequest.getContextPath() + "/admin/login";

        boolean isLoginRequest = httpRequest.getRequestURI().equals(loginURI);
        boolean isLoginPage = httpRequest.getRequestURI().endsWith("/login.jsp");

        if(isLoggedin && ( isLoginPage || isLoginRequest )){
            RequestDispatcher dispatcher = request.getRequestDispatcher("/admin/");
            dispatcher.forward(request, response);
        }
        else if(isLoggedin || isLoginRequest){
            chain.doFilter(request, response);
        }else {
            String loginPage = "/admin/login.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(loginPage);
            dispatcher.forward(request,response);
        }
    }
}
