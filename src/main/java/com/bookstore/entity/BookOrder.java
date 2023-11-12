package com.bookstore.entity;

import org.hibernate.annotations.NotFound;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Locale;
import java.util.Objects;

@Entity
@Table(name = "book_order", schema = "bookstoredb")
@NamedQueries({
        @NamedQuery(name="BookOrder.findAll",
                query="SELECT bo FROM BookOrder bo ORDER BY bo.orderDate DESC "),
        @NamedQuery(name="BookOrder.countAll",
                query="SELECT COUNT (bo) FROM BookOrder bo "),
        @NamedQuery(name="BookOrder.findByCustomer",
                query="SELECT bo FROM BookOrder bo WHERE bo.customerByCustomerId.customerId = :customerId " +
                        "ORDER BY bo.orderDate DESC "),
        @NamedQuery(name="BookOrder.findByCustomerAndId",
                query="SELECT bo FROM BookOrder bo WHERE bo.customerByCustomerId.customerId = :customerId " +
                        "AND bo.orderId = :orderId"),
})
public class BookOrder {
    private int orderId;
    private int customerId;
    private int bookCopies;
    private Timestamp orderDate;
    private String rAddressLine1;
    private String rAddressLine2;
    private String rFirstname;
    private String rLastname;
    private String rPhone;
    private String rCountry;
    private String countryName;
    private String rCity;
    private String rState;
    private String rZipcode;
    private String paymentMethod;
    private Double shippingFee;
    private Double tax;
    private Double subtotal;
    private double total;
    private String status;
    private Customer customerByCustomerId;
    private Collection<OrderDetail> orderDetailsByOrderId = new ArrayList<>();

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "order_id", nullable = false)
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    @Basic
    @Column(name = "customer_id", nullable = false, insertable = false, updatable = false)
    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    @Basic
    @Column(name = "order_date", nullable = false)
    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    @Basic
    @Column(name = "r_address_line1", nullable = false, length = 256)
    public String getrAddressLine1() {
        return rAddressLine1;
    }

    public void setrAddressLine1(String rAddressLine1) {
        this.rAddressLine1 = rAddressLine1;
    }

    @Basic
    @Column(name = "r_address_line2", nullable = true, length = 256)
    public String getrAddressLine2() {
        return rAddressLine2;
    }

    public void setrAddressLine2(String rAddressLine2) {
        this.rAddressLine2 = rAddressLine2;
    }

    @Basic
    @Column(name = "r_firstname", nullable = false, length = 30)
    public String getrFirstname() {
        return rFirstname;
    }

    public void setrFirstname(String rFirstname) {
        this.rFirstname = rFirstname;
    }

    @Basic
    @Column(name = "r_lastname", nullable = true, length = 30)
    public String getrLastname() {
        return rLastname;
    }

    public void setrLastname(String rLastname) {
        this.rLastname = rLastname;
    }

    @Basic
    @Column(name = "r_phone", nullable = false, length = 15)
    public String getrPhone() {
        return rPhone;
    }

    public void setrPhone(String rPhone) {
        this.rPhone = rPhone;
    }

    @Basic
    @Column(name = "r_country", nullable = true, length = 4)
    public String getrCountry() {
        return rCountry;
    }

    public void setrCountry(String rCountry) {
        this.rCountry = rCountry;
    }

    @Transient
    public String getCountryName() {
        return new Locale("", this.rCountry).getDisplayCountry();
    }

    @Basic
    @Column(name = "r_city", nullable = true, length = 32)
    public String getrCity() {
        return rCity;
    }

    public void setrCity(String rCity) {
        this.rCity = rCity;
    }

    @Basic
    @Column(name = "r_state", nullable = true, length = 45)
    public String getrState() {
        return rState;
    }

    public void setrState(String rState) {
        this.rState = rState;
    }

    @Basic
    @Column(name = "r_zipcode", nullable = true, length = 24)
    public String getrZipcode() {
        return rZipcode;
    }

    public void setrZipcode(String rZipcode) {
        this.rZipcode = rZipcode;
    }

    @Basic
    @Column(name = "payment_method", nullable = false, length = 20)
    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    @Basic
    @Column(name = "shipping_fee", nullable = true, precision = 0)
    public Double getShippingFee() {
        return shippingFee;
    }

    public void setShippingFee(Double shippingFee) {
        this.shippingFee = shippingFee;
    }

    @Basic
    @Column(name = "tax", nullable = true, precision = 0)
    public Double getTax() {
        return tax;
    }

    public void setTax(Double tax) {
        this.tax = tax;
    }

    @Basic
    @Column(name = "subtotal", nullable = true, precision = 0)
    public Double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(Double subtotal) {
        this.subtotal = subtotal;
    }

    @Basic
    @Column(name = "total", nullable = false, precision = 0)
    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    @Basic
    @Column(name = "status", nullable = false, length = 20)
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }


    @ManyToOne
    @JoinColumn(name = "customer_id", referencedColumnName = "customer_id", nullable = false)
    public Customer getCustomerByCustomerId() {
        return customerByCustomerId;
    }

    public void setCustomerByCustomerId(Customer customerByCustomerId) {
        this.customerByCustomerId = customerByCustomerId;
    }

    @OneToMany(mappedBy = "bookOrderByOrderId",fetch = FetchType.EAGER, cascade = CascadeType.ALL, orphanRemoval = true)
    public Collection<OrderDetail> getOrderDetailsByOrderId() {
        return orderDetailsByOrderId;
    }

    public void setOrderDetailsByOrderId(Collection<OrderDetail> orderDetailsByOrderId) {
        this.orderDetailsByOrderId = orderDetailsByOrderId;
    }
    @Transient
    public int getBookCopies() {
        int total = 0;
        for (OrderDetail orderDetail : orderDetailsByOrderId){
            total+= orderDetail.getQuantity() ;
        }
        return total;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        BookOrder order = (BookOrder) o;
        return orderId == order.orderId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(orderId);
    }
}