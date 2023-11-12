package com.bookstore.dao;

import com.bookstore.entity.*;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.*;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

class OrderDAOTest {
    private static OrderDAO orderDAO;
    private static BookDAO bookDAO;
    @BeforeEach
    public void setUp() {
        bookDAO = new BookDAO();
        orderDAO = new OrderDAO();
    }

    @Test
    void testCreateOrder() {
        BookOrder order = new BookOrder();
        Customer customer = new Customer();
        customer.setCustomerId(10);
        order.setCustomerByCustomerId(customer);
        order.setrFirstname("Dung");
        order.setrLastname("Huynh");
        order.setrPhone("1234567890");
        order.setStatus("Processing");
        order.setTotal(1.4f);
        order.setrAddressLine1("123 Tran Phu");
        order.setPaymentMethod("Paypal");

        List<OrderDetail> orderDetails = new ArrayList<>();
        OrderDetail orderDetail;
        orderDetail = new OrderDetail();
        orderDetail.setQuantity(1);
        orderDetail.setSubtotal(1.4f);
        Book book = bookDAO.get(25);
        orderDetail.setBookByBookId(book);
        orderDetail.setBookOrderByOrderId(order);

        OrderDetailPK orderDetailPK = new OrderDetailPK();
        orderDetailPK.setBook(book);
        orderDetailPK.setBookOrder(order);

        orderDetail.setId(orderDetailPK);

        orderDetails.add(orderDetail);

        order.setOrderDetailsByOrderId(orderDetails);
        BookOrder savedOrder = orderDAO.create(order);
        System.out.println(savedOrder.getOrderId());
        assertNotNull(savedOrder);
    }
    @Test
    public void testListAllOrder(){
        Collection<BookOrder> bookOrders = orderDAO.listAll();
        assertEquals(bookOrders, 5);
    }
    @Test
    public void testFindOrder(){
        BookOrder order = orderDAO.get(725);
        Customer customer = order.getCustomerByCustomerId();
        System.out.println(customer.getFirstname()+" "+customer.getLastname());
        assertNotNull(order);
    }
    @Test
    public void testUpdateOrder(){
        BookOrder order = orderDAO.get(725);
        String status = "Shipped";
        order.setStatus(status);
        BookOrder updatedOrder = orderDAO.update(order);
        assertEquals(updatedOrder.getStatus(), status);
    }
    @Test
    public void testUpdateBookOrderDetail(){
        Integer orderId = 1065;
        BookOrder order = orderDAO.get(orderId);

        String status = "Shipped";
        order.setStatus(status);

        List<OrderDetail> orderDetails = new ArrayList<>();
        OrderDetail orderDetail;
        orderDetail = new OrderDetail();
        orderDetail.setQuantity(3);
        orderDetail.setSubtotal(5.4f);
        Book book = bookDAO.get(25);

        OrderDetailPK orderDetailPK = new OrderDetailPK();
        orderDetailPK.setBook(book);
        orderDetailPK.setBookOrder(order);

        orderDetail.setId(orderDetailPK);

        orderDetails.add(orderDetail);

        order.setOrderDetailsByOrderId(orderDetails);

        orderDAO.update(order);
        BookOrder updatedOrder = orderDAO.get(orderId);
        System.out.println("quantity: " + updatedOrder.getOrderDetailsByOrderId().stream().findFirst().orElse(null).getQuantity());
        assertTrue(order.getOrderDetailsByOrderId().size() >0);
    }
    @Test
    public void testDeleteOrder(){
        orderDAO.delete(715);
        BookOrder order = orderDAO.get(715);
        assertNull(order);
    }

    @AfterEach
    void tearDown() {
        orderDAO.close();
    }
}