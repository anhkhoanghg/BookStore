package com.bookstore.controller.frontend.vnpay;

import com.bookstore.entity.BookOrder;
import com.google.gson.Gson;
import com.google.gson.JsonObject;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(name = "ajaxServlet", value = "/ajaxServlet")
public class ajaxServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        //String vnp_Command = "genqr";
        String vnp_OrderInfo = "Order on MapleBookStore";
        String orderType = "book";
        String vnp_TxnRef = Config.getRandomNumber(8);
        int mcId = Integer.parseInt(Config.getRandomNumber(8));
        int amountmc = Integer.parseInt(request.getParameter("amount"));
        String vnp_IpAddr = Config.getIpAddress(request);
        String vnp_TmnCode = Config.vnp_TmnCode;

        HttpSession session = request.getSession();
        BookOrder order = (BookOrder) session.getAttribute("order4VNPay");
        int amount = (int) (order.getTotal() * 100 * 23500);
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        String bank_code = "";
        if (bank_code != null && !bank_code.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bank_code);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", vnp_OrderInfo);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = "vn";
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_Returnurl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Date dt = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(dt);
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        Calendar cldvnp_ExpireDate = Calendar.getInstance();
        cldvnp_ExpireDate.add(Calendar.SECOND, 30);
        Date vnp_ExpireDateD = cldvnp_ExpireDate.getTime();
        String vnp_ExpireDate = formatter.format(vnp_ExpireDateD);

        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        List fieldNames = new ArrayList(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        Iterator itr = fieldNames.iterator();
        while (itr.hasNext()) {
            String fieldName = (String) itr.next();
            String fieldValue = (String) vnp_Params.get(fieldName);
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                //Build hash data
                hashData.append(fieldName);
                hashData.append('=');

                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                //Build query
                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                query.append('=');
                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                if (itr.hasNext()) {
                    query.append('&');
                    hashData.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        //String vnp_SecureHash = Config.Sha256(Config.vnp_HashSecret + hashData.toString());
        String vnp_SecureHash = Config.hmacSHA512(Config.vnp_HashSecret, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_apiUrl + "?" + queryUrl;
        com.google.gson.JsonObject job = new JsonObject();
        job.addProperty("code", "00");
        job.addProperty("message", "success");
        job.addProperty("data", paymentUrl);

        session.setAttribute("savingOrder", order);
        Gson gson = new Gson();
        response.getWriter().write(gson.toJson(job));;
    }
}
