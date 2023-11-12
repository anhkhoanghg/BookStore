package com.bookstore.controller.admin.order;

import com.bookstore.dao.BookDAO;
import com.bookstore.entity.Book;
import com.bookstore.entity.BookOrder;
import com.bookstore.entity.OrderDetail;
import com.bookstore.service.CommonUtitlity;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet(name = "AddBookToOrderServlet", value = "/admin/add_book_to_order")
public class AddBookToOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        BookDAO bookDAO = new BookDAO();
        Book book = bookDAO.get(bookId);

        HttpSession session = request.getSession();
        BookOrder order = (BookOrder) session.getAttribute("order");

        float subtotal = (float) (quantity * book.getPrice());
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setBookByBookId(book);
        orderDetail.setQuantity(quantity);
        orderDetail.setSubtotal(subtotal);

        Double newSubtotal = order.getSubtotal() + subtotal;
        Double newTax = order.getTax() + subtotal * 0.1;
        Double newShippingFee = order.getShippingFee() + quantity * 0.1;
        Double newTotal = newSubtotal + newShippingFee + newTax;

        order.setSubtotal(newSubtotal);
        order.setTax(newTax);
        order.setShippingFee(newShippingFee);
        order.setTotal(newTotal);

        order.getOrderDetailsByOrderId().add(orderDetail);
        request.setAttribute("book", book);
        session.setAttribute("NewBookPendingToAddToOrder", true);
        CommonUtitlity.forwardToPage("/admin/orders/add_book_result.jsp", request, response);
    }
}
