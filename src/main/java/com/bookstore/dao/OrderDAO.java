package com.bookstore.dao;

import com.bookstore.entity.BookOrder;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDAO extends JpaDAO<BookOrder> implements GenericDAO<BookOrder>{
    @Override
    public BookOrder create(BookOrder order) {
        Date date = new Date();
        order.setOrderDate(new Timestamp(date.getTime()));
        order.setStatus("Processing");
        return super.create(order);
    }
    @Override
    public BookOrder update(BookOrder bookOrder){return super.update(bookOrder);}
    @Override
    public BookOrder get(Object orderId) {
        return super.find(BookOrder.class, orderId);
    }

    public BookOrder get(int orderId, int customerId) {
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("customerId", customerId);
        parameters.put("orderId", orderId);
        List<BookOrder> result = super.findWithNamedQuery("BookOrder.findByCustomerAndId", parameters);
        if (!result.isEmpty()){
            return result.get(0);
        }
        return null;
    }

    @Override
    public void delete(Object orderId) {
        super.delete(BookOrder.class, orderId);
    }

    @Override
    public List<BookOrder> listAll() {
        return super.findWithNamedQuery("BookOrder.findAll");
    }

    public List<BookOrder> listAll(int page, int limit) {
        return super.findWithNamedQuery("BookOrder.findAll", page, limit);
    }
    @Override
    public long count() {
        return super.countWithNamedQuery("BookOrder.countAll");
    }
    public List<BookOrder> listByCustomer(int customerId){
        return super.findWithNamedQuery("BookOrder.findByCustomer",
                "customerId",customerId);
    }
    public long countOrderDetailByBook(int bookId) {
        return super.countWithNamedQuery("OrderDetail.countByBook", "bookId", bookId);
    }
    public long countByCustomer(int customerId) {
        return super.countWithNamedQuery("BookOrder.countByCustomer", "customerId", customerId);
    }
}
