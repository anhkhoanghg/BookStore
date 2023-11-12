package com.bookstore.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Embeddable
public class OrderDetailPK implements Serializable {

    private Book book;
    private BookOrder bookOrder;

    public OrderDetailPK() {
    }
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "book_id", referencedColumnName = "book_id", nullable = false, updatable = false, insertable = false)
    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", referencedColumnName = "order_id", nullable = false, updatable = false, insertable = false)
    public BookOrder getBookOrder() {
        return bookOrder;
    }

    public void setBookOrder(BookOrder bookOrder) {
        this.bookOrder = bookOrder;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        OrderDetailPK that = (OrderDetailPK) o;
        return book.equals(that.book) && bookOrder.equals(that.bookOrder);
    }

    @Override
    public int hashCode() {
        return Objects.hash(book, bookOrder);
    }
}