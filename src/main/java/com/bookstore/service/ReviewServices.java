package com.bookstore.service;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.ReviewDAO;
import com.bookstore.entity.Book;
import com.bookstore.entity.Customer;
import com.bookstore.entity.Review;
import com.bookstore.entity.Users;
import com.bookstore.store.Message;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ReviewServices {
    private HttpServletRequest request;
    private HttpServletResponse response;
    private ReviewDAO reviewDAO;
    private BookDAO bookDAO;

    public ReviewServices(HttpServletRequest request, HttpServletResponse response) {
        this.request = request;
        this.response = response;
        reviewDAO = new ReviewDAO();
        bookDAO = new BookDAO();
    }
    public void listReviews() throws ServletException, IOException {
        List<Review> reviewsList = reviewDAO.listAll();
        request.setAttribute("reviewsList", reviewsList);
        CommonUtitlity.forwardToPage("/admin/reviews/reviews_list.jsp", request, response);
    }

    public void submitReview() throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("bookId"));
        Integer rating = Integer.parseInt(request.getParameter("rating"));
        String headline = request.getParameter("headline");
        String comment = request.getParameter("comment");

        Review newReview = new Review();
        newReview.setHeadline(headline);
        newReview.setRating(rating);
        newReview.setComment(comment);

        Book book = bookDAO.get(bookId);
        newReview.setBookByBookId(book);

        Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
        newReview.setCustomerByCustomerId(customer);
        reviewDAO.create(newReview);

        Message message = new Message("Thank you", "Your review has been posted. Thank you!", "success");
        request.setAttribute("message", message);

        response.sendRedirect("/write_review?id="+bookId);
    }

    public void deleteReview() throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        Review review = reviewDAO.get(reviewId);
        if(review == null){
            Message message = new Message("Could not delete review", "Could not find review", "error");
            request.setAttribute("message", message);
        }else{
            reviewDAO.delete(reviewId);
            Message message = new Message("Delete successful", "Delete review successful", "success");
            request.setAttribute("message", message);
        }

    }
}
