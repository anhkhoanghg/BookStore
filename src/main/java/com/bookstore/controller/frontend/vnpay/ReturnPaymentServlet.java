package com.bookstore.controller.frontend.vnpay;

import com.bookstore.controller.frontend.shoppingcart.ShoppingCart;
import com.bookstore.dao.OrderDAO;
import com.bookstore.entity.BookOrder;
import com.bookstore.service.EmailServices;

import javax.mail.MessagingException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "ReturnPaymentServlet", value = "/return_payment")
public class ReturnPaymentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nextUrl = "/frontend/order/vnpay/return_payment.jsp";
        String vnp_TransactionStatus = "";

        HttpSession session = request.getSession();
        BookOrder order = (BookOrder) session.getAttribute("savingOrder");

        OrderDAO orderDAO = new OrderDAO();
        BookOrder savedOrder = orderDAO.create(order);

        Map fields = new HashMap();
        for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }
        //get attribute
        double amount = Integer.parseInt(request.getParameter("vnp_Amount"));
        String code = request.getParameter("vnp_TransactionNo");
        String day = request.getParameter("vnp_PayDate");
        String info = request.getParameter("vnp_OrderInfo");
        String bank = request.getParameter("vnp_BankCode");
        String transId = request.getParameter("vnp_TxnRef");
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }
        String signValue = Config.hashAllFields(fields);
        String name = "";
        Object uname = request.getSession().getAttribute("username");
        if(uname == null) {
            name = "";
        }
        else {
            name = uname.toString();
        }

        try {
            EmailServices.sendEmail("smtp.gmail.com", "587", "phichh16@gmail.com",
                    "knkatubzsdmcrnps", order.getCustomerByCustomerId().getEmail(),
                    "Invoice on Maple BookStore #"+savedOrder.getOrderId() ,
                    EmailServices.createInvoideMessage(savedOrder));
        } catch (MessagingException e) {
            e.printStackTrace();
        }

        vnp_TransactionStatus = "Success";
        request.setAttribute("status", vnp_TransactionStatus);
        request.setAttribute("order", savedOrder);
        request.setAttribute("orderId", order.getOrderId());

        session.removeAttribute("order");
        session.removeAttribute("savingOrder");
        session.removeAttribute("order4VNPay");
        session.setAttribute("cart", new ShoppingCart());
        request.getRequestDispatcher(nextUrl).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
