package com.bookstore.dao;

import com.bookstore.entity.Book;
import com.bookstore.entity.Customer;
import com.bookstore.entity.Review;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class ReviewDAOTest {
    private static ReviewDAO reviewDAO;

    @BeforeEach
    void setUp() {
        reviewDAO = new ReviewDAO();
    }
    @Test
    public void testCreateReview(){
        Review review =  new Review();
        Book book = new Book();
        Customer customer = new Customer();

        book.setBookId(24);
        customer.setCustomerId(8);

        review.setCustomerByCustomerId(customer);
        review.setRating(2);
        review.setBookByBookId(book);
        review.setHeadline("This is a very good book");
        review.setComment(" 2 star ");

        Review newReview = reviewDAO.create(review);
        assertTrue(newReview.getReviewId() > 0);

    }
    @Test
    public void testFindReview(){
        Integer reviewId = 1;
        Review review = reviewDAO.get(reviewId);
        assertNotNull(review);
    }
    @Test
    public void testUpdateReview(){
        Integer reviewId = 1;
        Review review = reviewDAO.get(reviewId);
        review.setHeadline("Good book");

        Review updatedReview = reviewDAO.update(review);
        assertEquals(review.getHeadline(), updatedReview.getHeadline());
    }
    @Test
    public void testDeleteReview(){
        Integer reviewId = 2;
        reviewDAO.delete(reviewId);
        Review review = reviewDAO.get(reviewId);
        assertNull(review);
    }

    @AfterEach
    void tearDown() {
        reviewDAO.close();
    }
}