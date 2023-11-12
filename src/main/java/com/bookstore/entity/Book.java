package com.bookstore.entity;

import javax.persistence.*;
import java.sql.Date;
import java.sql.Timestamp;
import java.util.*;

@Entity
@NamedQueries({
        @NamedQuery(name="Book.findAll",
                query="SELECT b FROM Book b ORDER BY b.title"),
        @NamedQuery(name="Book.countAll",
                query="SELECT COUNT(b) FROM Book b "),
        @NamedQuery(name="Book.findByTitle",
                query="SELECT b FROM Book b WHERE b.title = :title"),
        @NamedQuery(name="Book.search",
                query="SELECT b FROM Book b WHERE b.title LIKE  CONCAT('%',:keyword,'%') " +
                        "OR b.author LIKE CONCAT('%',:keyword,'%')"),
        @NamedQuery(name="Book.countByKeyword",
                query="SELECT COUNT(b) FROM Book b WHERE b.title LIKE  CONCAT('%',:keyword,'%') " +
                        "OR b.author LIKE CONCAT('%',:keyword,'%')"),
        @NamedQuery(name="Book.searchWithCategory",
                query="SELECT b FROM Book b WHERE b.categoryByCategoryId.categoryId = :categoryId AND " +
                        "(b.title LIKE  CONCAT('%',:keyword,'%') " +
                        "OR b.author LIKE CONCAT('%',:keyword,'%'))"),
        @NamedQuery(name="Book.countByKeywordAndCategory",
                query="SELECT COUNT(b) FROM Book b WHERE b.categoryByCategoryId.categoryId = :categoryId AND " +
                        "(b.title LIKE  CONCAT('%',:keyword,'%') " +
                        "OR b.author LIKE CONCAT('%',:keyword,'%'))"),
        @NamedQuery(name="Book.findByCategory",
                query="SELECT b FROM Book b JOIN " +
                        "Category c ON b.categoryByCategoryId.categoryId = c.categoryId AND c.categoryId = :categoryId " +
                        "ORDER BY b.bookId DESC"),
        @NamedQuery(name="Book.countByCategory",
                query="SELECT COUNT(b) FROM Book b WHERE b.categoryByCategoryId.categoryId = :categoryId"),
        @NamedQuery(name="Book.listNew",
                query="SELECT b FROM Book b ORDER BY b.publishDate DESC "),
})
public class Book {
    private int bookId;
    private String title;
    private String author;
    private String description;
    private String isbn;
    private byte[] image;
    private int[] ratingPercentArr;
    private int[] ratingArr;
    private double price;
    private Date publishDate;
    private String base64Image;
    private float averageRating;
    private String ratingStars;
    private Timestamp lastUpdateTime;
    private int categoryId;
    private Category categoryByCategoryId;
    private Collection<OrderDetail> orderDetailsByBookId;
    private Collection<Review> reviewsByBookId;

    public Book(int bookId) {
        this.bookId = bookId;
    }

    public Book() {
    }


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "book_id", nullable = false)
    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    @Basic
    @Column(name = "title", nullable = false, length = 128)
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    @Basic
    @Column(name = "author", nullable = false, length = 64)
    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    @Basic
    @Column(name = "description", nullable = false, length = -1)
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Basic
    @Column(name = "isbn", nullable = false, length = 15)
    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    @Basic
    @Column(name = "image", nullable = false)
    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    @Basic
    @Column(name = "price", nullable = false, precision = 0)
    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Basic
    @Column(name = "publish_date", nullable = false)
    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    @Basic
    @Column(name = "last_update_time", nullable = false)
    public Timestamp getLastUpdateTime() {
        return lastUpdateTime;
    }

    public void setLastUpdateTime(Timestamp lastUpdateTime) {
        this.lastUpdateTime = lastUpdateTime;
    }

    @Basic
    @Column(name = "category_id", nullable = false, insertable = false, updatable = false)
    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Book book = (Book) o;

        if (bookId != book.bookId) return false;
        if (Double.compare(book.price, price) != 0) return false;
        if (categoryId != book.categoryId) return false;
        if (title != null ? !title.equals(book.title) : book.title != null) return false;
        if (author != null ? !author.equals(book.author) : book.author != null) return false;
        if (description != null ? !description.equals(book.description) : book.description != null) return false;
        if (isbn != null ? !isbn.equals(book.isbn) : book.isbn != null) return false;
        if (!Arrays.equals(image, book.image)) return false;
        if (publishDate != null ? !publishDate.equals(book.publishDate) : book.publishDate != null) return false;
        if (lastUpdateTime != null ? !lastUpdateTime.equals(book.lastUpdateTime) : book.lastUpdateTime != null)
            return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result;
        long temp;
        result = bookId;
        result = 31 * result + (title != null ? title.hashCode() : 0);
        result = 31 * result + (author != null ? author.hashCode() : 0);
        result = 31 * result + (description != null ? description.hashCode() : 0);
        result = 31 * result + (isbn != null ? isbn.hashCode() : 0);
        result = 31 * result + Arrays.hashCode(image);
        temp = Double.doubleToLongBits(price);
        result = 31 * result + (int) (temp ^ (temp >>> 32));
        result = 31 * result + (publishDate != null ? publishDate.hashCode() : 0);
        result = 31 * result + (lastUpdateTime != null ? lastUpdateTime.hashCode() : 0);
        result = 31 * result + categoryId;
        return result;
    }

    @ManyToOne
    @JoinColumn(name = "category_id", referencedColumnName = "category_id", nullable = false)
    public Category getCategoryByCategoryId() {
        return categoryByCategoryId;
    }

    public void setCategoryByCategoryId(Category categoryByCategoryId) {
        this.categoryByCategoryId = categoryByCategoryId;
    }

    @OneToMany(mappedBy = "bookByBookId", fetch = FetchType.LAZY)
    public Collection<OrderDetail> getOrderDetailsByBookId() {
        return orderDetailsByBookId;
    }

    public void setOrderDetailsByBookId(Collection<OrderDetail> orderDetailsByBookId) {
        this.orderDetailsByBookId = orderDetailsByBookId;
    }

    @OneToMany(mappedBy = "bookByBookId", fetch = FetchType.EAGER)
    public Collection<Review> getReviewsByBookId() {
        return reviewsByBookId;
    }

    public void setReviewsByBookId(Collection<Review> reviewsByBookId) {
        this.reviewsByBookId = reviewsByBookId;
    }

    public void setSortedReviews(){
        TreeSet<Review> sortedReviews = new TreeSet<>(new Comparator<Review>() {
            @Override
            public int compare(Review review1, Review review2) {
                return review2.getReviewTime().compareTo(review1.getReviewTime());
            }
        });
        sortedReviews.addAll(reviewsByBookId);
        this.reviewsByBookId = sortedReviews;
    }

    @Transient
    public String getBase64Image() {
        return base64Image = Base64.getEncoder().encodeToString(this.image);
    }
    @Transient
    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
    }
    public void setAverageRating(){
        float averageRating = 0.0f;
        float sum = 0.0f;

        if (reviewsByBookId.isEmpty()){
            this.averageRating = 0;
        }else {
            for (Review review:reviewsByBookId){
                sum += review.getRating();
            }
            averageRating = sum/reviewsByBookId.size();
            this.averageRating = (float) Math.round(averageRating * 100) / 100;
        }
    }
    @Transient
    public float getAverageRating(){
        return this.averageRating;
    }
    @Transient
    public String getRatingString(float averageRating){
        String result = "";
        int numberStarOn = (int) averageRating;
        for (int i = 1; i <= numberStarOn; i++ ){
            result += "on,";
        }
        int next = numberStarOn + 1;
        if (averageRating > numberStarOn){
            result += "half,";
            next ++;
        }
        for (int j = next; j <= 5; j++ ){
            result += "off,";
        }
        return result.substring(0, result.length() - 1);
    }
    @Transient
    public void setRatingStars(){
        float averageRating = getAverageRating();
        ratingStars = getRatingString(averageRating);
    }
    @Transient
    public String getRatingStars(){
        return ratingStars;
    }
    @Transient
    public void setRatingPercentArr(){
        this.ratingPercentArr = new int[] {0, 0, 0, 0, 0};
        int[] ratingArr = new int[] {0, 0, 0, 0, 0};
        for (Review review: reviewsByBookId) {
            review.setStars();
            ratingArr[5 - review.getRating()] += 1;
        }
        this.ratingArr = ratingArr;
        for (int i = 0; i < ratingArr.length; i++){
            if(ratingArr[i] != 0){
                this.ratingPercentArr[i] = (ratingArr[i] * 100) / this.reviewsByBookId.size();
            }else{
                this.ratingPercentArr[i] = 0;
            }
        }
    }
    @Transient
    public int[] getRatingArr(){
        return this.ratingArr;
    }
    @Transient
    public int[] getRatingPercentArr(){
        return this.ratingPercentArr;
    }
}
