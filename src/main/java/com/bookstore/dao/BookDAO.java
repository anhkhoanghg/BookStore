package com.bookstore.dao;

import com.bookstore.entity.Book;

import java.sql.Timestamp;
import java.util.*;


public class BookDAO extends JpaDAO<Book> implements GenericDAO<Book>{
    public BookDAO() {

    }
    @Override
    public Book create(Book book) {
        Date date = new Date();
        book.setLastUpdateTime(new Timestamp(date.getTime()));
        return super.create(book);
    }

    @Override
    public Book update(Book book) {
        return super.update(book);
    }

    @Override
    public Book get(Object bookId) {
        Book book = super.find(Book.class, bookId);
        book.setAverageRating();
        book.setRatingStars();
        book.setRatingPercentArr();
        return book;
    }

    @Override
    public void delete(Object bookId) {
        super.delete(Book.class, bookId);
    }

    @Override
    public List<Book> listAll() {
        return super.findWithNamedQuery("Book.findAll");
    }
    public List<Book> listAll(int page, int limit) {
        return super.findWithNamedQuery("Book.findAll", page, limit);
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Book.countAll");
    }

    public long countByKeyword(String keyword){
        return super.countWithNamedQuery("Book.countByKeyword","keyword", keyword);
    }
    public long countByKeywordAndCategory(String keyword, int categoryId){
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("keyword",keyword);
        parameters.put("categoryId",categoryId);
        return super.countWithNamedQuery("Book.countByKeywordAndCategory", parameters);
    }

    public long countByCategory(int categoryId){
        return super.countWithNamedQuery("Book.countByCategory","categoryId",categoryId);
    }

    public Book findByTitle(String title){
        List<Book> result = super.findWithNamedQuery("Book.findByTitle","title",title);
        if(!result.isEmpty()){
            return result.get(0);
        }
        return null;
    }

    public List<Book> search(String keyword, int page, int limit){
        return super.findWithNamedQuery("Book.search","keyword",keyword, page, limit);
    }
    public List<Book> search(String keyword, int categoryId, int page, int limit){
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("keyword",keyword);
        parameters.put("categoryId",categoryId);
        return super.findWithNamedQuery("Book.searchWithCategory", parameters, page, limit);
    }

    public List<Book> listNewBooks(){
        return super.findWithNamedQuery("Book.listNew",1, 10);
    }

    public List<Book> listBooksByCategory(int categoryId, int page, int limit) {
        return super.findWithNamedQuery("Book.findByCategory", "categoryId", categoryId, page, limit);
    }
    public List<Book> listBestSellingBooks(){
        return super.findWithNamedQuery("OrderDetail.bestSelling",1,10);
    }
    public List<Book> listMostFavoredBooks(){
        List<Book> mostFavoredBooks = new ArrayList<>();
        List<Object[]> results = super.findWithNamedQueryObjects("Review.mostFavoredBook",1,10);
        if (!results.isEmpty()){
            for (Object[] elements: results){
                Book book = (Book) elements[0];
                book.setAverageRating();
                mostFavoredBooks.add(book);
            }
        }
        return mostFavoredBooks;
    }
}
