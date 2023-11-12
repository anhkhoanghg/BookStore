package com.bookstore.entity;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "order_detail", schema = "bookstoredb", catalog = "")
@NamedQueries({
        @NamedQuery(name = "OrderDetail.bestSelling", query = "SELECT od.bookByBookId FROM OrderDetail od " +
                "GROUP BY od.bookByBookId.bookId ORDER BY SUM(od.quantity) DESC"),
        @NamedQuery(name = "OrderDetail.countByBook",
                query = "SELECT COUNT(od) FROM OrderDetail od WHERE od.bookByBookId.bookId =:bookId"),
        @NamedQuery(name = "BookOrder.countByCustomer",
                query = "SELECT COUNT(bo.orderId) FROM BookOrder bo WHERE bo.customerByCustomerId.customerId =:customerId")
})
public class OrderDetail {
    private OrderDetailPK id = new OrderDetailPK();
    private int quantity;
    private double subtotal;
    private Book bookByBookId;
    private BookOrder bookOrderByOrderId;

    public OrderDetail() {
    }

    public OrderDetail(OrderDetailPK id, int quantity, double subtotal, Book bookByBookId, BookOrder bookOrderByOrderId) {
        this.id = id;
        this.quantity = quantity;
        this.subtotal = subtotal;
        this.bookByBookId = bookByBookId;
        this.bookOrderByOrderId = bookOrderByOrderId;
    }

    public OrderDetail(OrderDetailPK id) {
        this.id = id;
    }

    @EmbeddedId
        @AttributeOverrides({
                @AttributeOverride(name = "book.bookId", column = @Column(name = "book_id", nullable = false)),
                @AttributeOverride(name = "bookOrder.orderId", column = @Column(name = "order_id", nullable = false)),
        })
    public OrderDetailPK getId() {
        return id;
    }

    public void setId(OrderDetailPK id) {
        this.id = id;
    }

    @Basic
    @Column(name = "quantity", nullable = false)
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Basic
    @Column(name = "subtotal", nullable = false, precision = 0)
    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrderDetail that = (OrderDetail) o;
        return quantity == that.quantity && Double.compare(that.subtotal, subtotal) == 0 && id.equals(that.id) && bookByBookId.equals(that.bookByBookId) && bookOrderByOrderId.equals(that.bookOrderByOrderId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, quantity, subtotal, bookByBookId, bookOrderByOrderId);
    }

    @ManyToOne
    @JoinColumn(name = "book_id", referencedColumnName = "book_id", nullable = false, updatable = false, insertable = false)
    public Book getBookByBookId() {
        return bookByBookId;
    }

    public void setBookByBookId(Book bookByBookId) {
        this.bookByBookId = bookByBookId;
    }

    @ManyToOne
    @JoinColumn(name = "order_id", referencedColumnName = "order_id", nullable = false, updatable = false, insertable = false)
    public BookOrder getBookOrderByOrderId() {
        return bookOrderByOrderId;
    }

    public void setBookOrderByOrderId(BookOrder bookOrderByOrderId) {
        this.bookOrderByOrderId = bookOrderByOrderId;
    }
}