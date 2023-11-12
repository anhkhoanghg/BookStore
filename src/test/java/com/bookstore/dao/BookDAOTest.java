package com.bookstore.dao;

import com.bookstore.entity.Book;
import com.bookstore.entity.Category;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import javax.persistence.EntityNotFoundException;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class BookDAOTest {
    private static BookDAO bookDAO;

    @BeforeEach
    public void setUp() {
        bookDAO = new BookDAO();
    }
    @Disabled
    @Test
    public void testCreateBook(){
        Book book = new Book();
        book.setCategoryId(1);
        book.setTitle("Adventures of Sherlock Holmes");
        book.setAuthor("Sir Arthur Conan Doyle");
        book.setDescription("Presenting 12 tales starring the legendary British detective Sherlock Holmes, this 1892 book is Arthur Conan Doyle's first short-story collection. The mystery compilation includes some of Holmes's finest cases with his dutiful sidekick, Doctor Watson, most notably \"A Scandal in Bohemia,\" in which Holmes matches wits with the crafty former lover of a European king. Also featured is \"The Adventure of the Red-Headed League,\" a study in misdirection that unfolds to become a much larger scheme. The stories, initially published in the Strand Magazine, are essential reading for Holmes fans.\n");
        book.setIsbn("0123456789");
        book.setPrice(38.78f);
        bookDAO.create(book);
    }
    @Test public void testGetBook(){
        Integer bookId = 24;
        Book book = bookDAO.get(bookId);
        assertNotNull(book);
    }
    @Test public void testGetBookNotFound(){
        Integer bookId = 1;
        Book book = bookDAO.get(bookId);
        assertNull(book);
    }
    @Disabled
    @Test
    public void testDeleteBookNotFound(){
        Integer bookId = 100;
        assertThrows(EntityNotFoundException.class, () -> {
            bookDAO.delete(bookId);
        });
    }
    @Disabled
    @Test
    public void testDeleteBook(){
        Integer bookId = 1;
        bookDAO.delete(bookId);
        Book book = bookDAO.get(bookId);
        assertNull(book);
    }
    @Test
    public void testListAll(){
        List<Book> bookList = bookDAO.listAll();
        for (Book book : bookList){
            System.out.println(book.getTitle());
        }
        assertFalse(bookList.isEmpty());
    }
    @Test
    public void testFindByTitleNotFound(){
        String title = "Java 18";
        Book book = bookDAO.findByTitle(title);
        assertNull(book);
    }
    @Test
    public void testFindByTitle(){
        String title = "EU drug regulator: Unusual blood clot is 'very rare AstraZeneca side effect'";
        Book book = bookDAO.findByTitle(title);
        assertNotNull(book);
    }
    @Test
    public void testSetRatingPercentArr(){
        Integer bookId = 24;
        Book book = bookDAO.get(bookId);
        book.setRatingPercentArr();
        assertEquals(book.getRatingPercentArr()[3], 50);
    }


    @AfterEach
    public void tearDown() {
        bookDAO.close();
    }

}