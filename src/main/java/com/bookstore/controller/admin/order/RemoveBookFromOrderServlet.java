package com.bookstore.controller.admin.order;

import com.bookstore.entity.BookOrder;
import com.bookstore.entity.OrderDetail;
import com.bookstore.service.CommonUtitlity;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.Collection;
import java.util.Iterator;

@WebServlet(name = "RemoveBookFromOrderServlet", value = "/admin/remove_book_from_order")
public class RemoveBookFromOrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));
        HttpSession session = request.getSession();
        BookOrder order = (BookOrder) session.getAttribute("order");

        request.setAttribute("mapCountries",CommonUtitlity.mapCountries());

        Collection<OrderDetail> orderDetails = order.getOrderDetailsByOrderId();
        Iterator<OrderDetail> iterator = orderDetails.iterator();
        while (iterator.hasNext()){
            OrderDetail orderDetail = iterator.next();
            if (orderDetail.getBookByBookId().getBookId() == bookId){
                Double newTax = order.getTax() - orderDetail.getSubtotal() * 0.1;
                Double newShippingFee = order.getShippingFee() - orderDetail.getQuantity() * 0.1;
                Double newSubtotal = order.getSubtotal() - orderDetail.getSubtotal();
                Double newTotal = newSubtotal + newShippingFee + newTax;

                order.setSubtotal(newSubtotal);
                order.setTax(newTax);
                order.setShippingFee(newShippingFee);
                order.setTotal(newTotal);
                iterator.remove();
            }
        }
        CommonUtitlity.forwardToPage("/admin/orders/order_form.jsp", request, response);
    }

}
