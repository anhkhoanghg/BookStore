package com.bookstore.controller.frontend;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(filterName = "CustomerLoginFilter", urlPatterns = "/*")
public class CustomerLoginFilter implements Filter {
    private static final String[] loginRequiredURLs = {
            "/profile","/edit_profile", "/update_profile", "/write_review",
            "/checkout", "/place_order","/view_orders", "/show_order_detail"
    };
    public void init(FilterConfig config) throws ServletException {

    }

    public void destroy() {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpSession session = httpServletRequest.getSession(false);

        String path = httpServletRequest.getRequestURI().substring(httpServletRequest.getContextPath().length());
        if (path.startsWith("/admin/")){
            chain.doFilter(request, response);
            return;
        }

        String requestURL = httpServletRequest.getRequestURI().toString();
        boolean isLoggedIn = session != null && session.getAttribute("loggedCustomer") != null;


        if (!isLoggedIn && isLoginRequired(requestURL)){
            String queryString = httpServletRequest.getQueryString();
            String redirectURL = requestURL;
            if (queryString != null){
                redirectURL = redirectURL.concat("?").concat(queryString);
            }
            if(session == null){
                httpServletRequest.getSession(true);
            }
            session.setAttribute("redirectURL", redirectURL);

            String loginPage = "/frontend/customer/register_form.jsp";
            RequestDispatcher dispatcher = httpServletRequest.getRequestDispatcher(loginPage);
            dispatcher.forward(request, response);
        }else {
            chain.doFilter(request, response);
        }
    }
    private boolean isLoginRequired(String requestURL){
        for (String  loginRequiredURL:loginRequiredURLs){
            if (requestURL.contains(loginRequiredURL)){
                return true;
            }
        }
        return false;
    }
}
