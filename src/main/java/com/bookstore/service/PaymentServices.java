package com.bookstore.service;

import com.bookstore.entity.Book;
import com.bookstore.entity.BookOrder;
import com.bookstore.entity.Customer;
import com.bookstore.entity.OrderDetail;
import com.paypal.api.payments.*;
import com.paypal.base.rest.APIContext;
import com.paypal.base.rest.PayPalRESTException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class PaymentServices {
    private static final String CLIENT_ID = "AYp7TN8y1qQwIoeQvaFt8nUUlc7YvO-16PnvboNxDSIKh0leSYMGLonK-exw63IhUh0oAUBVt8hlttQu";
    private static final String CLIENT_SECRET = "ENf5xqN1WlYcsOqi7BElz7G6PlpGSZsB1BWk-qLFKHwUUnAZI0E-W18QHW_r7Ak79pVva5xSswdNpGHl";
    private String mode = "sandbox";

    private HttpServletRequest request;
    private HttpServletResponse response;

    public PaymentServices(HttpServletRequest request, HttpServletResponse response) {
        super();
        this.request = request;
        this.response = response;
    }
    public void authorizedPayment(BookOrder order) throws ServletException, IOException {
        Payer payer = getPayerInformation(order);
        RedirectUrls redirectUrls = getRedirectUrls();

        List<Transaction> transactions = getTransactionInformation(order);

        Payment requestPayment = new Payment();
        requestPayment.setPayer(payer)
                .setRedirectUrls(redirectUrls)
                .setIntent("authorize")
                .setTransactions(transactions);

        System.out.println("====== REQUEST PAYMENT: ======");
        System.out.println(requestPayment);

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
        try {
            Payment authorizedPayment = requestPayment.create(apiContext);
            System.out.println("====== AUTHORIZED PAYMENT: ======");
            System.out.println(authorizedPayment);

            String approvalURL = getApprovalURL(authorizedPayment);
            response.sendRedirect(approvalURL);
        }catch (PayPalRESTException e){
            e.printStackTrace();
            throw new ServletException("Error in authorizing payment.");
        }
    }

    private String getApprovalURL(Payment authorizedPayment) {
        String approvalURL = null;
        List<Links> links = authorizedPayment.getLinks();
        for (Links link: links){
            if (link.getRel().equalsIgnoreCase("approval_url")){
                approvalURL = link.getHref();
                break;
            }
        }
        return approvalURL;
    }

    private List<Transaction> getTransactionInformation(BookOrder order){
        Transaction transaction = new Transaction();
        transaction.setDescription("Books ordered on Online Book Store");
        Amount amount = getAmountDetails(order);
        transaction.setAmount(amount);

        ItemList itemList = new ItemList();
        ShippingAddress shippingAddress = getRecipientInformation(order);
        itemList.setShippingAddress(shippingAddress);

        List<Item> paypalItems = new ArrayList<>();
        Iterator<OrderDetail> iterator = order.getOrderDetailsByOrderId().iterator();

        while (iterator.hasNext()){
            OrderDetail orderDetail = iterator.next();
            Book book = orderDetail.getId().getBook();
            Integer quantity = orderDetail.getQuantity();

            Item paypalItem = new Item();
            paypalItem.setCurrency("USD")
                    .setName(book.getTitle())
                    .setQuantity(String.valueOf(quantity))
                    .setPrice(String.format("%.2f", book.getPrice()));
            paypalItems.add(paypalItem);
        }

        itemList.setItems(paypalItems);
        transaction.setItemList(itemList);

        List<Transaction> listTransaction = new ArrayList<>();
        listTransaction.add(transaction);

        return listTransaction;
    }
    private ShippingAddress getRecipientInformation(BookOrder order){
        ShippingAddress shippingAddress = new ShippingAddress();
        String recipientName = order.getrFirstname() + " " + order.getrLastname();
        shippingAddress.setRecipientName(recipientName)
                .setPhone(order.getrPhone())
                .setLine1(order.getrAddressLine1())
                .setLine2(order.getrAddressLine2())
                .setCity(order.getrCity())
                .setState(order.getrState())
                .setCountryCode(order.getrCountry())
                .setPostalCode(order.getrZipcode());
        return shippingAddress;
    }

    private Payer getPayerInformation(BookOrder order ){
        Payer payer = new Payer();
        payer.setPaymentMethod("paypal");

        Customer customer = order.getCustomerByCustomerId();

        PayerInfo payerInfo = new PayerInfo();
        payerInfo.setFirstName(customer.getFirstname());
        payerInfo.setLastName(customer.getLastname());
        payerInfo.setEmail(customer.getEmail());
        payer.setPayerInfo(payerInfo);

        return payer;
    }

    private RedirectUrls getRedirectUrls(){
        String requestURL = request.getRequestURL().toString();
        String requestURI = request.getRequestURI();
        String baseURL = requestURL.replace(requestURI, "").concat(request.getContextPath());

        RedirectUrls redirectUrls = new RedirectUrls();
        String cancelURL = baseURL.concat("/view_cart");
        String returnURL = baseURL.concat("/review_payment");

        System.out.println("Return URL: " + returnURL);
        System.out.println("Cancel URL: " + cancelURL);

        redirectUrls.setCancelUrl(cancelURL);
        redirectUrls.setReturnUrl(returnURL);

        return redirectUrls;
    }
    private Amount getAmountDetails(BookOrder order){
        Details details = new Details();
        details.setShipping(String.format("%.2f", order.getShippingFee()));
        details.setTax(String.format("%.2f", order.getTax()));
        details.setSubtotal(String.format("%.2f", order.getSubtotal()));

        Amount amount = new Amount();
        amount.setCurrency("USD");
        amount.setDetails(details);
        amount.setTotal(String.format("%.2f", order.getTotal()));

        return amount;
    }

    public void reviewPayment() throws ServletException, IOException {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");
        if (payerId == null || paymentId ==  null){
            throw new ServletException("Error in displaying payment review");
        }
        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
        try {
            Payment payment = Payment.get(apiContext, paymentId);

            PayerInfo payerInfo = payment.getPayer().getPayerInfo();
            Transaction transaction = payment.getTransactions().get(0);
            ShippingAddress shippingAddress = transaction.getItemList().getShippingAddress();

            request.setAttribute("payerInfo", payerInfo);
            request.setAttribute("transaction", transaction);
            request.setAttribute("shippingAddress", shippingAddress);

            CommonUtitlity.forwardToPage("/frontend/order/review_payment.jsp?paymentId=" + paymentId
                    +"&PayerID=" + payerId, request, response);
        }catch (PayPalRESTException | IOException e){
            e.printStackTrace();
            throw new ServletException("Error in getting payment details from Paypal.");
        }
    }

    public Payment executePayment() throws PayPalRESTException {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");

        PaymentExecution paymentExecution = new PaymentExecution();
        paymentExecution.setPayerId(payerId);

        Payment payment = new Payment().setId(paymentId);

        APIContext apiContext = new APIContext(CLIENT_ID, CLIENT_SECRET, mode);
        return payment.execute(apiContext, paymentExecution);
    }
}
