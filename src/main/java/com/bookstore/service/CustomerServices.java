package com.bookstore.service;

import com.bookstore.dao.CustomerDAO;
import com.bookstore.dao.HashGenerator;
import com.bookstore.dao.OrderDAO;
import com.bookstore.dao.ReviewDAO;
import com.bookstore.entity.Customer;
import com.bookstore.store.Message;

import javax.mail.MessagingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class CustomerServices {
    private HttpServletRequest request;
    private HttpServletResponse response;
    private CustomerDAO customerDAO;
    private ReviewDAO reviewDAO;
    private OrderDAO orderDAO;
    public CustomerServices(HttpServletRequest request, HttpServletResponse response) {
        customerDAO = new CustomerDAO();
        reviewDAO = new ReviewDAO();
        orderDAO = new OrderDAO();
        this.request = request;
        this.response = response;
    }
    public void listCustomers() throws ServletException, IOException {
        List<Customer> customersList = customerDAO.listAll();
        request.setAttribute("customersList", customersList);
        CommonUtitlity.forwardToPage("/admin/customers/customers_list.jsp", request, response);
    }
    public void readCustomerFields(Customer customer){
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String addressLine1 = request.getParameter("addressLine1");
        String addressLine2 = request.getParameter("addressLine2");
        String city = request.getParameter("city");
        String state = request.getParameter("state");
        String zipcode = request.getParameter("zipcode");
        String country = request.getParameter("country");
        String email = request.getParameter("email");
        if(email != null && !email.equals("")){
            customer.setEmail(email);
        }

        if (password != null && !password.isEmpty()) {
            String encryptedPassword = HashGenerator.generateMD5(password);
            customer.setPassword(encryptedPassword);
        }

        customer.setFirstname(firstname);
        customer.setLastname(lastname);
        customer.setPhone(phone);
        customer.setAddressLine1(addressLine1);
        customer.setAddressLine2(addressLine2);
        customer.setCity(city);
        customer.setState(state);
        customer.setZipcode(zipcode);
        customer.setCountry(country);
    }
    public void createCustomer() throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        Customer existCustomer = customerDAO.findByEmail(email);
        Customer customer = new Customer();
        if(existCustomer != null){
            Message message = new Message("Could not create customer", "A customer with email " +email +" already exist","error");

            request.setAttribute("message", message);
            request.setAttribute("customer", customer);
            CommonUtitlity.forwardToPage("/admin/customers/customer_form.jsp", message, request, response);
        }else {
            customer.setEmail(email);
            customer.setPassword(password);
            customer.setFirstname(firstname);
            customer.setLastname(lastname);
            customerDAO.create(customer);
            Message message = new Message("Create successful", "Create customer successful", "success");
            request.setAttribute("message", message);
        }
    }
    public void registerCustomer(String host, String port, String username, String pass) throws ServletException, IOException {
        String email = request.getParameter("email");
        Customer existCustomer = customerDAO.findByEmail(email);
        Customer customer = new Customer();

        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");

        customer.setFirstname(firstname);
        customer.setLastname(lastname);
        customer.setPassword(password);
        if(existCustomer != null){
            Message message = new Message("Could not register", "A customer with email " +email +" already exist","error");
            request.setAttribute("message", message);
            customer.setEmail("");
            request.setAttribute("customer", customer);
            showLogin();
        }else {
            String code = EmailServices.getRandom();
            customer.setCode(code);

            boolean test;
            try {
                test = EmailServices.sendEmail(host, port, username, pass, email, "Email Verification",
                        "<p>Registered successfully.Please verify your account using this code: " + customer.getCode() + "</p>");
            } catch (MessagingException e) {
                e.printStackTrace();
                test = false;
            }
            if(test){
                HttpSession session  = request.getSession();
                customer.setEmail(email);
                session.setAttribute("customer", customer);
            }
            response.sendRedirect("/verify");
        }

    }
    public void saveCustomer() throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        Customer existCustomer = customerDAO.findByEmail(customer.getEmail());

        if(existCustomer != null){
            Message message = new Message("Could not register", "A customer with email " +customer.getEmail() +" already exist","error");
            request.setAttribute("message", message);
            request.setAttribute("customer", customer);
            showLogin();
        }else {
            customerDAO.create(customer);
            session.setAttribute("loggedCustomer", customer);
            session.removeAttribute("customer");
        }
    }

    public void editCustomer() throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("id"));
        Customer customer = customerDAO.get(customerId);
        if(customer == null){
            Message message = new Message("Customer not found", "Could not find customer with ID " + customerId,"error");
            List<Customer> customersList = customerDAO.listAll();
            request.setAttribute("customersList", customersList);
            CommonUtitlity.forwardToPage("/admin/customers/customers_list.jsp", message, request, response);
        }else {
            request.setAttribute("customer", customer);
            CommonUtitlity.forwardToPage("/admin/customers/customer_form.jsp", request, response);
        }
    }

    public void updateCustomer() throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String email = request.getParameter("email");
        Customer existCustomer = customerDAO.findByEmail(email);
        Customer customer = new Customer();
        readCustomerFields(customer);
        if(existCustomer != null && existCustomer.getCustomerId() != customerId){
            Message message = new Message("Could not update customer", "A customer with email " +email +" already exist","error");
            customer.setEmail("");
            request.setAttribute("customer", customer);
            CommonUtitlity.forwardToPage("/admin/customers/customer_form.jsp", message, request, response);
        }else {
            customerDAO.update(customer);
            Message message = new Message("Update successful", "Update customer successful", "success");
            request.setAttribute("message", message);
        }

    }

    public void deleteCustomer() {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        Customer customer = customerDAO.get(customerId);
        if(customer == null){
            Message message = new Message("Could not delete customer", "Could not find customer", "error");
            request.setAttribute("message", message);
        }else{
            if(reviewDAO.findByCustomer(customerId).size() > 0){
                Message message = new Message("Delete failure", "Could not delete customer (ID: " + customerId
                        + " ) because it currently contains some reviews", "error");
                request.setAttribute("message", message);
            }
            else if (orderDAO.countByCustomer(customerId) > 0){
                Message message = new Message("Delete failure", "Could not delete customer (ID: " + customerId
                        + " ) because it currently contains some orders", "error");
                request.setAttribute("message", message);
            }
            else {
                customerDAO.delete(customerId);
                Message message = new Message("Delete successful", "Delete customer successful", "success");
                request.setAttribute("message", message);
            }

        }
    }

    public void showLogin() throws ServletException, IOException {
        HttpSession session = request.getSession();
        Message message = (Message) session.getAttribute("message");
        request.setAttribute("message", message);
        session.removeAttribute("message");
        CommonUtitlity.forwardToPage("/frontend/customer/register_form.jsp", request, response);
    }

    public void doLogin() throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Customer customer = customerDAO.checkLogin(email, password);

        if(customer != null){
            Message message = new Message("Login successful", "User is authenticated", "success");
            request.getSession().setAttribute("message", message);

            HttpSession session = request.getSession();
            session.setAttribute("loggedCustomer", customer);
            Object objRedirectURL = session.getAttribute("redirectURL");


            if (objRedirectURL != null) {
                String redirectPage = (String) objRedirectURL;
                session.removeAttribute("redirectURL");
                response.sendRedirect(redirectPage);
            } else {
                response.sendRedirect("/");
            }
        }else {
            Message message = new Message("Login fail", "Please enter email and password is registered", "error");
            request.setAttribute("message", message);
            showLogin();
        }
    }

    public void showCustomerProfile() throws ServletException, IOException {
        request.setAttribute("mapCountries",CommonUtitlity.mapCountries());
        HttpSession session = request.getSession();
        String msg = (String) session.getAttribute("msg");
        if (msg != null){
            request.setAttribute("msg", msg);
            session.removeAttribute("msg");
        }
        CommonUtitlity.forwardToPage("/frontend/customer/profile.jsp", request, response);
    }

    public void  updateCustomerProfile() {
        Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
        readCustomerFields(customer);
        customerDAO.update(customer);
    }

    public void changeCustomerPassword() {
        Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = customer.getEmail();

        if(confirmPassword.equals(newPassword)){
            customer = customerDAO.checkLogin(email, currentPassword);
            Message message = new Message("Change password", "Please check your current password", "error");
            request.setAttribute("message", message);
            if(customer!= null){
                customerDAO.changePassword(customer, newPassword);
                message = new Message("Change password ", "Change password successful", "success");
                request.setAttribute("message", message);
            }
        } else {
            Message message = new Message("Change password", "Confirm password does not match new password" , "error");
            request.setAttribute("message", message);
        }
    }
}
