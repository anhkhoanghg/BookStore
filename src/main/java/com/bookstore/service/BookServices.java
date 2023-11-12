package com.bookstore.service;

import com.bookstore.dao.BookDAO;
import com.bookstore.dao.CategoryDAO;
import com.bookstore.dao.OrderDAO;
import com.bookstore.dao.ReviewDAO;
import com.bookstore.entity.Book;
import com.bookstore.entity.Category;
import com.bookstore.entity.Customer;
import com.bookstore.store.Message;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.List;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class BookServices {

    private BookDAO bookDAO;
    private CategoryDAO categoryDAO;
    private ReviewDAO reviewDAO;
    private OrderDAO orderDAO;
    private HttpServletRequest request;
    private HttpServletResponse response;

    public BookServices( HttpServletRequest request, HttpServletResponse response){

        bookDAO = new BookDAO();
        reviewDAO = new ReviewDAO();
        categoryDAO = new CategoryDAO();
        orderDAO = new OrderDAO();
        this.request = request;
        this.response = response;
    }
    public void listBooks() throws ServletException, IOException {
        String pageNum = request.getParameter("page");
        int page = 1;
        if(pageNum != null) page = Integer.parseInt(pageNum);
        int limit = 5;

        int numOfBook = (int) bookDAO.count();
        List<Book> booksList = bookDAO.listAll(page, limit);

        int numOfPages = 0;
        if(numOfBook != 0){
            numOfPages = numOfBook/limit;
        }
        if(numOfBook % limit != 0){
            numOfPages ++;
        }
        request.setAttribute("numOfPages", numOfPages);
        request.setAttribute("page", page);

        request.setAttribute("booksList", booksList);
        CommonUtitlity.forwardToPage("/admin/books/books_list.jsp", request, response);
    }
    public void showBookNewForm() throws ServletException, IOException {
        CommonUtitlity.forwardToPage("/admin/books/book_form.jsp", request, response);
    }
    public void createBook() throws ServletException, IOException {
        Book book = new Book();
        readBookFields(book);
        String title = book.getTitle();
        Book existBook = bookDAO.findByTitle(title);
        if (existBook != null){
            Message message = new Message("Could not create book",
                    "A book with title \"" +existBook.getTitle() +"\" already exist",
                    "error");
            request.setAttribute("message", message);
            return;
        }
        Book createdBook = bookDAO.create(book);
        if(createdBook.getBookId() > 0){
            Message message = new Message("Create successful", "Create book successful", "success");
            request.setAttribute("message", message);
        }


    }
    public void readBookFields(Book book) throws ServletException, IOException {
        Integer categoryId = Integer.parseInt(request.getParameter("category"));
        Category category = categoryDAO.get(categoryId);
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String description = request.getParameter("description");
        String isbn = request.getParameter("isbn");
        float price = Float.parseFloat(request.getParameter("price"));
        Date publishDate;

        publishDate = Date.valueOf(request.getParameter("publishDate"));

        book.setTitle(title);
        book.setCategoryByCategoryId(category);
        book.setAuthor(author);
        book.setDescription(description);
        book.setIsbn(isbn);
        book.setPublishDate(publishDate);
        book.setPrice(price);
        Part part = request.getPart("bookImage");
        if(part != null && part.getSize() > 0){
            long size = part.getSize();
            byte[] imageBytes =new byte[(int) size];
            InputStream inputStream = part.getInputStream();
            inputStream.read(imageBytes);
            inputStream.close();
            book.setImage(imageBytes);
        }

    }

    public void editBook() throws ServletException, IOException {
        Integer bookId = Integer.parseInt(request.getParameter("id"));
        Book book = bookDAO.get(bookId);
        if (book != null){
            request.setAttribute("book", book);
            CommonUtitlity.forwardToPage("/admin/books/book_form.jsp", request, response);
        } else {
            Message message = new Message("Book not found", "Could not find book with ID " + bookId,"error");
            List<Book> booksList = bookDAO.listAll();
            request.setAttribute("booksList", booksList);

            CommonUtitlity.forwardToPage("/admin/books/books_list.jsp", message, request, response);
        }
    }

    public void updateBook() throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book book = bookDAO.get(bookId);
        Book bookByTitle = bookDAO.findByTitle(request.getParameter("title"));
        readBookFields(book);
        if(bookByTitle != null && book.getBookId() != bookByTitle.getBookId()){
            Message message = new Message("Could not update book",
                    "A book with title " +bookByTitle.getTitle() +" already exist",
                    "error");

            request.setAttribute("message", message);
        }else {
            bookDAO.update(book);
            Message message = new Message("Update successful", "Update book successful",
                    "success");
            request.setAttribute("message", message);
        }

    }

    public void deleteBook() {
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        Book book = bookDAO.get(bookId);

        if(book == null){
            Message message = new Message("Could not delete book", "Could not find book with Id "+
                    bookId, "error");
            request.setAttribute("message", message);
        }else {
            if(reviewDAO.findByBook(bookId).size() > 0){
                Message message = new Message("Delete failure", "Could not delete book (ID: " + bookId
                        + " ) because it currently contains some reviews", "error");
                request.setAttribute("message", message);
            }
            else if (orderDAO.countOrderDetailByBook(bookId) > 0){
                Message message = new Message("Delete failure", "Could not delete book (ID: " + bookId
                        + " ) because it currently contains some orders", "error");
                request.setAttribute("message", message);
            }
            else {
                bookDAO.delete(bookId);
                Message message = new Message("Delete successful", "Delete book successful", "success");
                request.setAttribute("message", message);
            }
        }

    }

    public void listBooksByCategory() throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("id"));
        int page = Integer.parseInt(request.getParameter("page"));
        Category category = categoryDAO.get(categoryId);
        if (category == null){
            Message message = new Message("Cound not find category" ,
                    "Sorry, the category ID " + categoryId + " is not available.",
                    "error");
            request.setAttribute("message", message);
            request.getRequestDispatcher("/frontend/index.jsp").forward(request, response);
            return;
        }
        int limit = 8;
        List<Book> booksList = bookDAO.listBooksByCategory(categoryId, page, limit);
        int numOfBook = (int) bookDAO.countByCategory(categoryId);
        int numOfPages = 0;
        if(numOfBook != 0){
            numOfPages = numOfBook/limit;
        }
        if(numOfBook % limit != 0){
            numOfPages ++;
        }
        request.setAttribute("booksList",booksList);
        request.setAttribute("category", category);
        request.setAttribute("numOfPages", numOfPages);
        request.setAttribute("page", page);

        CommonUtitlity.forwardToPage("/frontend/book/book_list_by_category.jsp", request, response);
    }

    public void viewBookDetail() throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));
        Book book = bookDAO.get(bookId);
        book.setSortedReviews();
        String destPage = "/frontend/book/book_detail.jsp";

        Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");
        if(customer != null){
            request.setAttribute("submitReviewLink", "/submit_review");
        } else {
            request.setAttribute("submitReviewLink", "/write_review?id="+bookId);
        }

        if (book != null){
            request.setAttribute("book",book);
        }else {
            destPage = "/frontend/index.jsp";
            Message message = new Message("Could not find book",
                    "Sorry, the book with ID " + bookId + " is not available.",
                    "error");
            request.setAttribute("message", message);
        }

        CommonUtitlity.forwardToPage(destPage, request, response);
    }

    public void search() throws ServletException, IOException {
        String keyword = request.getParameter("q");
        int page = Integer.parseInt(request.getParameter("page"));
        String category = request.getParameter("category");
        List<Book> result = null;
        int limit = 8;
        int numOfBook = 0;

        if(keyword.equals("")){
            if(category != null && category != ""){
                int categoryId = Integer.parseInt(request.getParameter("category"));
                result = bookDAO.listBooksByCategory(categoryId, page, limit);
                numOfBook = (int) bookDAO.countByCategory(categoryId);
                request.setAttribute("category", category);
            }else {
                result = bookDAO.listAll(page, limit);
                numOfBook = (int) bookDAO.count();
            }
        } else {
            if(category != null && category != ""){
                int categoryId = Integer.parseInt(request.getParameter("category"));
                result = bookDAO.search(keyword, categoryId, page, limit);
                numOfBook = (int) bookDAO.countByKeywordAndCategory(keyword, categoryId);
                request.setAttribute("category", category);
            }else {
                result = bookDAO.search(keyword, page, limit);
                numOfBook = (int) bookDAO.countByKeyword(keyword);
                request.setAttribute("category", "");
            }

        }

        int numOfPages = 0;
        if(numOfBook != 0){
            numOfPages = numOfBook/limit;
        }
        if(numOfBook % limit != 0){
            numOfPages ++;
        }
        request.setAttribute("numOfPages", numOfPages);
        request.setAttribute("limit", limit);
        request.setAttribute("numOfBook", numOfBook);
        request.setAttribute("q",keyword);
        request.setAttribute("page", page);
        request.setAttribute("result", result);

        CommonUtitlity.forwardToPage("/frontend/book/search_result.jsp", request, response);

    }
}

