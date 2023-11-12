package com.bookstore.dao;

import com.bookstore.entity.Review;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ReviewDAO extends JpaDAO<Review> implements GenericDAO<Review> {

    public ReviewDAO() {

    }

    @Override
    public Review create(Review review) {
        Date date = new Date();
        review.setReviewTime(new Timestamp(date.getTime()));
        return super.create(review);
    }

    @Override
    public Review update(Review review) {
        return super.update(review);
    }

    @Override
    public Review get(Object reviewId) {
        return super.find(Review.class, reviewId);
    }

    @Override
    public void delete(Object reviewId) {
        super.delete(Review.class, reviewId);
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Review.countAll");
    }

    @Override
    public List<Review> listAll() {
        return super.findWithNamedQuery("Review.findAll");
    }
    public Review findByCustomerAndBook(Integer customerId, Integer bookId){
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("customerId", customerId);
        parameters.put("bookId", bookId);
        List<Review> result = super.findWithNamedQuery("Review.findByCustomerAndBook", parameters);
        if(!result.isEmpty()){
            return result.get(0);
        }
        return null;
    }
    public List<Review> findByBook( Integer bookId){
        List<Review> result = super.findWithNamedQuery("Review.findByBook", "bookId", bookId);
        return result;
    }

    public List<Review> findByCustomer(Integer customerId){
        List<Review> result = super.findWithNamedQuery("Review.findByCustomer", "customerId", customerId);
        return result;
    }
}
