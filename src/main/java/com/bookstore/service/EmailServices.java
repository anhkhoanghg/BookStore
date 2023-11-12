package com.bookstore.service;



import com.bookstore.entity.BookOrder;
import com.bookstore.entity.OrderDetail;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.*;

public class EmailServices {
    public static boolean sendEmail(String host, String port,
                                    final String email, final String password, String toAddress,
                                    String subject, String message) throws AddressException,
            MessagingException {

        // sets SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");

        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(email, password);
            }
        };

        Session session = Session.getInstance(properties, auth);

        // creates a new e-mail message
        Message msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(email));
        InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        msg.setContent(message, "text/html");

        try {
            // sends the e-mail
            Transport.send(msg);
        } catch (Exception e){
            return false;
        }

        return true;

    }

    //generate vrification code
    public static String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    public static String createInvoideMessage(BookOrder order){
        NumberFormat numberFormat = new DecimalFormat("###,###,###.00");
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd MMMM, yyyy");
        String invoiceHeader = "<div class=\"invoice-box\" style=\"max-width: 800px;margin: auto;padding: 30px;border: 1px solid #eee;box-shadow: 0 0 10px rgba(0, 0, 0, .15);font-size: 16px;line-height: 24px;font-family: 'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;color: #555;\">\n" +
                "    <table style=\"width: 100%;line-height: inherit;text-align: left;\">\n" +
                "        <tr class=\"top\">\n" +
                "            <td colspan=\"2\" style=\"padding: 5px;vertical-align: top;\">\n" +
                "                <table style=\"width: 100%;line-height: inherit;text-align: left;\">\n" +
                "                    <tr>\n" +
                "                        <td class=\"title\" style=\"padding: 5px;vertical-align: top;padding-bottom: 20px;font-size: 45px;line-height: 45px;color: #333;\">\n" +
                "                            <img src=\"https://res.cloudinary.com/deq5twgl5/image/upload/v1637562542/books_ofadwm.png\" style=\"height: 100px; width: auto;\">\n" +
                "                        </td>\n" +
                "\n" +
                "                        <td style=\"padding: 5px;vertical-align: top;text-align: right;padding-bottom: 20px;\">\n" +
                "                            Invoice #: " + order.getOrderId() +"<br>\n" +
                "                            Created: " + dateFormat.format(order.getOrderDate()) +"<br>\n" +
                "                        </td>\n" +
                "                    </tr>\n" +
                "                </table>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "\n" +
                "        <tr class=\"information\">\n" +
                "            <td colspan=\"2\" style=\"padding: 5px;vertical-align: top;\">\n" +
                "                <table style=\"width: 100%;line-height: inherit;text-align: left;\">\n" +
                "                    <tr>\n" +
                "                        <td style=\"padding: 5px;vertical-align: top;padding-bottom: 40px;\">\n" +
                "                            Maple BookStore, Inc.<br>\n" +
                "                            12345 Sunny Road<br>\n" +
                "                            Sunnyville, TX 12345\n" +
                "                        </td>\n" +
                "\n" +
                "                        <td style=\"padding: 5px;vertical-align: top;text-align: right;padding-bottom: 40px;\">\n" +
                "                            "+ order.getrFirstname() + " " + order.getrLastname() +"<br>\n" +
                "                            "+ order.getrPhone() + "<br>\n" +
                "                            "+ order.getrAddressLine1() + ",<br>\n" +
                "                            "+ order.getrState() + ", "+ order.getrCity() + ", "+ order.getrZipcode() + ", "+ order.getCountryName() + ",<br>\n" +
                "                        </td>\n" +
                "                    </tr>\n" +
                "                </table>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "\n";

                String invoiceBody = "        <tr class=\"heading\">\n" +
                "            <td style=\"padding: 5px;vertical-align: top;background: #eee;border-bottom: 1px solid #ddd;font-weight: bold;\">\n" +
                "                Payment Method\n" +
                "            </td>\n" +
                "\n" +
                "            <td style=\"padding: 5px;vertical-align: top;text-align: right;background: #eee;border-bottom: 1px solid #ddd;font-weight: bold;\">\n" +
                "                Check #\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "\n" +
                "        <tr class=\"details\">\n" +
                "            <td style=\"padding: 5px;vertical-align: top;padding-bottom: 20px;\">\n" +
                "                "+ order.getPaymentMethod() + "\n" +
                "            </td>\n" +
                "\n" +
                "            <td style=\"padding: 5px;vertical-align: top;text-align: right;padding-bottom: 20px;\">\n" +
                "                " + order.getOrderId() +"\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "\n" ;

                String invoiceDetails = "        <tr class=\"heading\">\n" +
                "            <td style=\"padding: 5px;vertical-align: top;background: #eee;border-bottom: 1px solid #ddd;font-weight: bold;\">\n" +
                "                Item\n" +
                "            </td>\n" +
                "\n" +
                "            <td style=\"padding: 5px;vertical-align: top;text-align: right;background: #eee;border-bottom: 1px solid #ddd;font-weight: bold;\">\n" +
                "                Price\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "\n";

        Collection<OrderDetail> orderDetails = order.getOrderDetailsByOrderId();
        for (OrderDetail orderDetail : orderDetails){
            invoiceDetails += "        <tr class=\"item\">\n" +
                    "            <td style=\"padding: 5px;vertical-align: top;border-bottom: 1px solid #eee;\">\n" +
                    "                " + orderDetail.getBookByBookId().getTitle() + "\n" +
                    "            </td>\n" +
                    "\n" +
                    "            <td style=\"padding: 5px;vertical-align: top;text-align: right;border-bottom: 1px solid #eee;\">\n" +
                    "                $" + numberFormat.format(orderDetail.getSubtotal()) + "\n" +
                    "            </td>\n" +
                    "        </tr>\n" +
                    "\n" ;
        }

        invoiceDetails += "        <tr class=\"total\">\n" +
                "            <td style=\"padding: 5px;vertical-align: top;\"></td>\n" +
                "\n" +
                "            <td style=\"padding: 5px;vertical-align: top;text-align: right;border-top: 2px solid #eee;font-weight: bold;\">\n" +
                "                Total: $" + numberFormat.format(order.getSubtotal()) + "<br>\n" +
                "                Tax: $" + numberFormat.format(order.getTax()) + "<br>\n" +
                "                Shipping Fee: $" + numberFormat.format(order.getShippingFee()) + "<br>\n" +
                "                Total: $" + numberFormat.format(order.getTotal()) + "<br>\n" +
                "            </td>\n" +
                "        </tr>\n" +
                "    </table>\n" +
                "</div>\n" +
                "\n";

                return invoiceHeader + invoiceBody + invoiceDetails;
    }
}
