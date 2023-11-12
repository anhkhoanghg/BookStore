package com.bookstore.service;

import com.bookstore.controller.frontend.shoppingcart.ShoppingCart;
import com.bookstore.dao.BookDAO;
import com.bookstore.dao.OrderDAO;
import com.bookstore.entity.*;
import com.bookstore.store.Message;
import com.paypal.api.payments.ItemList;
import com.paypal.api.payments.Payment;
import com.paypal.api.payments.ShippingAddress;


import javax.mail.MessagingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

public class BookOrderServices {
    private HttpServletRequest request;
    private HttpServletResponse response;
    private OrderDAO orderDAO;
    private BookDAO bookDAO;

    public BookOrderServices(HttpServletRequest request, HttpServletResponse response) {
        orderDAO = new OrderDAO();
        bookDAO = new BookDAO();
        this.request = request;
        this.response = response;
    }
    public void listOrders() throws ServletException, IOException {
        String pageNum = request.getParameter("page");
        int page = 1;
        if(pageNum != null) page = Integer.parseInt(pageNum);
        int limit = 10;

        int numOfOrder = (int) orderDAO.count();
        List<BookOrder> ordersList = orderDAO.listAll(page, limit);

        int numOfPages = 0;
        if(numOfOrder != 0){
            numOfPages = numOfOrder/limit;
        }
        if(numOfOrder % limit != 0){
            numOfPages ++;
        }
        HttpSession session = request.getSession();
        session.removeAttribute("order");

        request.setAttribute("numOfPages", numOfPages);
        request.setAttribute("page", page);
        request.setAttribute("ordersList",ordersList);
        CommonUtitlity.forwardToPage("/admin/orders/orders_list.jsp", request, response);
    }

    public void showCheckOutForm() throws ServletException, IOException {
        HttpSession session = request.getSession();
        ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");
        if (shoppingCart != null){
            Double tax = shoppingCart.getTotalAmount() * 0.1;
            Double shippingFee = shoppingCart.getTotalQuantity() * 0.1;
            Double total = shoppingCart.getTotalAmount() + tax + shippingFee;

            session.setAttribute("tax", tax);
            session.setAttribute("shippingFee", shippingFee);
            session.setAttribute("total", total);
            request.setAttribute("mapCountries",CommonUtitlity.mapCountries());

            CommonUtitlity.forwardToPage("/frontend/order/checkout.jsp", request, response);
        }else {
            response.sendRedirect("/view_cart");
        }
    }

    public void placeOrder() throws ServletException, IOException {
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("loggedCustomer");
        if(customer.getCountry() == null || customer.getAddressLine1() == null || customer.getZipcode() == null
                || customer.getCountryName() == null || customer.getCity() == null || customer.getState() == null){
            session.setAttribute("msg", "Please update your address.");
            response.sendRedirect("/profile");
        } else {
            String paymentMethod = request.getParameter("paymentMethod");
            BookOrder order = readOrderInfo();
            if (paymentMethod.equals("paypal")){
                PaymentServices paymentServices = new PaymentServices(request, response);
                session.setAttribute("order4Paypal", order);
                paymentServices.authorizedPayment(order);
            }
            else if(paymentMethod.equals("vnpay")){
                session.setAttribute("order4VNPay", order);
                response.sendRedirect("/review_vnpay_payment");
            }
            else {
                placeOrderCOD(order);
            }
        }

    }

    private BookOrder readOrderInfo(){
        String paymentMethod = request.getParameter("paymentMethod");
        String rFirstname = request.getParameter("rFirstname");
        String rLastname = request.getParameter("rLastname");
        String rPhone =  request.getParameter("rPhone");
        String rAddressLine1 = request.getParameter("rAddressLine1");
        String rAddressLine2 = request.getParameter("rAddressLine2");
        String rState = request.getParameter("rState");
        String rCity = request.getParameter("rCity");
        String rZipcode = request.getParameter("rZipcode");
        String rCountry = request.getParameter("rCountry");

        BookOrder order = new BookOrder();
        order.setrFirstname(rFirstname);
        order.setrLastname(rLastname);
        order.setrPhone(rPhone);
        order.setrAddressLine1(rAddressLine1);
        order.setrAddressLine2(rAddressLine2);
        order.setrState(rState);
        order.setrCity(rCity);
        order.setrZipcode(rZipcode);
        order.setrCountry(rCountry);
        order.setPaymentMethod(paymentMethod);

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("loggedCustomer");
        order.setCustomerByCustomerId(customer);

        ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");
        Map<Book, Integer> items = shoppingCart.getItems();

        Iterator<Book> iterator = items.keySet().iterator();

        Set<OrderDetail> orderDetails = new HashSet<>();

        while (iterator.hasNext()){
            Book book = iterator.next();
            Integer quantity = items.get(book);
            float subtotal = (float) (quantity * book.getPrice());

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setQuantity(quantity);
            orderDetail.setSubtotal(subtotal);

            orderDetail.setBookByBookId(book);
            orderDetail.setBookOrderByOrderId(order);

            OrderDetailPK orderDetailPK = new OrderDetailPK();
            orderDetailPK.setBook(book);
            orderDetailPK.setBookOrder(order);

            orderDetail.setId(orderDetailPK);

            orderDetails.add(orderDetail);
        }
        order.setOrderDetailsByOrderId(orderDetails);
        Double tax = (Double) session.getAttribute("tax");
        Double shippingFee = (Double) session.getAttribute("shippingFee");
        Double total = (Double) session.getAttribute("total");

        order.setSubtotal((double) shoppingCart.getTotalAmount());
        order.setTax(tax);
        order.setShippingFee(shippingFee);
        order.setTotal(total);
        return order;
    }
    public Integer placeOrderPaypal(Payment payment){
        BookOrder order = (BookOrder) request.getSession().getAttribute("order4Paypal");
        ItemList itemList = payment.getTransactions().get(0).getItemList();
        String paymentTotal = payment.getTransactions().get(0).getAmount().getTotal();

        String orderTotal = String.format("%.2f",order.getTotal());

        ShippingAddress shippingAddress = itemList.getShippingAddress();
        String shippingPhoneNumber = itemList.getShippingPhoneNumber();
        boolean validPayment = paymentTotal.equals(orderTotal);
        String recipientName = shippingAddress.getRecipientName();
        String[] names = recipientName.split(" ");
        order.setrFirstname(names[0]);
        order.setrLastname(names[1]);
        order.setrAddressLine1(shippingAddress.getLine1());
        order.setrAddressLine2(shippingAddress.getLine2());
        order.setrPhone(shippingPhoneNumber);
        order.setrCity(shippingAddress.getCity());
        order.setrState(shippingAddress.getState());
        order.setrCountry(shippingAddress.getCountryCode());
        order.setrZipcode(shippingAddress.getPostalCode());
        if (!validPayment) {
            List<OrderDetail> orderDetails = new ArrayList<>();
            itemList.getItems().forEach( item -> {
                Book book = bookDAO.findByTitle(item.getName());
                OrderDetail orderDetail = new OrderDetail();
                System.out.println(book.getTitle());
                OrderDetailPK orderDetailPK = new OrderDetailPK();
                orderDetailPK.setBook(book);
                orderDetailPK.setBookOrder(order);

                orderDetail.setId(orderDetailPK);
                orderDetail.setQuantity(Integer.parseInt(item.getQuantity()));
                orderDetail.setSubtotal(Double.parseDouble(item.getPrice()) * Integer.parseInt(item.getQuantity()));
                orderDetails.add(orderDetail);
            });
            order.setOrderDetailsByOrderId(orderDetails);
        }
        return saveOrder(order);
    }
    private Integer saveOrder(BookOrder order){
        BookOrder createdOrder = orderDAO.create(order);

        HttpSession session = request.getSession();
        session.setAttribute("orderId", createdOrder.getOrderId());
        ShoppingCart shoppingCart = (ShoppingCart) session.getAttribute("cart");
        shoppingCart.clear();
        try {
            EmailServices.sendEmail("smtp.gmail.com", "587", "phichh16@gmail.com",
                    "knkatubzsdmcrnps", order.getCustomerByCustomerId().getEmail(),
                    "Invoice on Maple BookStore #"+ createdOrder.getOrderId(),
                    EmailServices.createInvoideMessage(createdOrder));
        } catch (MessagingException e) {
            e.printStackTrace();
        }
        return  createdOrder.getOrderId();
    }

    private void placeOrderCOD(BookOrder order) throws IOException {
        int orderId = saveOrder(order);

        HttpSession session = request.getSession();
        Message message = new Message("Thank you, your order has been received.",
                "We will deliver your book within a few days. ",
                "error");
        session.setAttribute("message", message);
        response.sendRedirect("/show_order_detail?id=" + orderId);
    }

    public void listOrdersbyCustomer() throws ServletException, IOException {
        Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
        List<BookOrder> listOrders = orderDAO.listByCustomer(customer.getCustomerId());
        request.setAttribute("listOrders", listOrders);

        CommonUtitlity.forwardToPage("/frontend/order/orders_list.jsp", request, response);

    }
    public void viewOrderDetailForAdmin() throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        BookOrder order = orderDAO.get(orderId);
        if (order != null) {
            request.setAttribute("order", order);
            CommonUtitlity.forwardToPage("/admin/orders/order_detail.jsp", request, response);
        } else {
            Message message = new Message( "View order", "Could not find order with ID " + orderId, "error");
            CommonUtitlity.forwardToPage("/admin/orders/orders_list.jsp", message, request, response);
        }
    }
    public void showEditOrderForm() throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        BookOrder order = orderDAO.get(orderId);

        if (order == null) {
            Message message = new Message("Edit order fail", "Could not find order with ID " + orderId,"error");
            CommonUtitlity.forwardToPage("/admin/list_orders", message, request, response);
        }

        HttpSession session = request.getSession();
        Object isPendingBook = session.getAttribute("NewBookPendingToAddToOrder");
        request.setAttribute("mapCountries",CommonUtitlity.mapCountries());

        if (isPendingBook == null) {
            session.setAttribute("order", order);
        } else {
            session.removeAttribute("NewBookPendingToAddToOrder");
        }

        CommonUtitlity.forwardToPage("/admin/orders/order_form.jsp", request, response);
    }

    public void showOrderDetailForCustomer() throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("loggedCustomer");

        Message message = (Message) session.getAttribute("message");
        if(message != null){
            request.setAttribute("message", message );
            session.removeAttribute("message");
        }
        BookOrder order = orderDAO.get(orderId, customer.getCustomerId());
        request.setAttribute("order",order);

        CommonUtitlity.forwardToPage("/frontend/order/order_details.jsp", request, response);
    }
    public void updateOrder(){
        HttpSession session = request.getSession();
        BookOrder order = (BookOrder) session.getAttribute("order");

        String rFirstname = request.getParameter("rFirstname");
        String rLastname = request.getParameter("rLastname");
        String rAddressLine1 = request.getParameter("rAddressLine1");
        String rAddressLine2 = request.getParameter("rAddressLine2");
        String rPhone = request.getParameter("rPhone");
        String rCity = request.getParameter("rCity");
        String rState = request.getParameter("rState");
        String rZipcode = request.getParameter("rZipcode");
        String rCountry = request.getParameter("rCountry");

        Double shippingFee = Double.parseDouble(request.getParameter("shippingFee"));
        Double tax = Double.parseDouble(request.getParameter("tax"));

        String paymentMethod = request.getParameter("paymentMethod");
        String status = request.getParameter("status");

        order.setrFirstname(rFirstname);
        order.setrLastname(rLastname);
        order.setrPhone(rPhone);
        order.setrAddressLine1(rAddressLine1);
        order.setrAddressLine2(rAddressLine2);
        order.setrCity(rCity);
        order.setrState(rState);
        order.setrZipcode(rZipcode);
        order.setShippingFee(shippingFee);
        order.setTax(tax);
        order.setrCountry(rCountry);

        order.setPaymentMethod(paymentMethod);
        order.setStatus(status);

        String[] arrayBookId = request.getParameterValues("bookId");
        String[] arrayPrice = request.getParameterValues("price");
        String[] arrayQuantity = new String[arrayBookId.length];

        for (int i = 1; i <= arrayQuantity.length; i++){
            arrayQuantity[i-1] = request.getParameter("quantity"+i);
        }
        Collection<OrderDetail> orderDetails = order.getOrderDetailsByOrderId();
        orderDetails.clear();

        Double totalAmount = 0.0;
        for (int i = 0; i < arrayBookId.length; i++){
            int bookId = Integer.parseInt(arrayBookId[i]);
            int quantity = Integer.parseInt(arrayQuantity[i]);
            Double subtotal = Double.parseDouble(arrayPrice[i]);

            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setQuantity(quantity);
            orderDetail.setSubtotal(subtotal);

            Book book = bookDAO.get(bookId);

            OrderDetailPK orderDetailPK = new OrderDetailPK();
            orderDetailPK.setBook(book);
            orderDetailPK.setBookOrder(order);

            orderDetail.setId(orderDetailPK);

            orderDetails.add(orderDetail);
            totalAmount += subtotal;
        }
        order.setSubtotal(totalAmount);
        totalAmount += shippingFee;
        totalAmount += tax;
        order.setTotal(totalAmount);
        orderDAO.update(order);

        Message message = new Message("Update order", "The order "+ order.getOrderId() + " has been updated successfully", "success");
        request.setAttribute("message", message);
    }

    public void deleteOrder() throws ServletException, IOException {
        Integer orderId = Integer.parseInt(request.getParameter("orderId"));
        BookOrder order = orderDAO.get(orderId);

        if (order != null) {
            orderDAO.delete(orderId);

            Message message = new Message("Delete successful",
                    "The order ID " + orderId + " has been deleted.",
                    "success");
            request.setAttribute("message", message);
        } else {
            Message message = new Message("Could not delete order",
                    "Could not find order with ID " + orderId +
                            ", or it might have been deleted by another admin.",
                    "error");
            request.setAttribute("message", message);
        }
    }


}
