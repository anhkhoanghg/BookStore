package com.bookstore.dao;

import com.bookstore.entity.Category;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;

import javax.persistence.EntityNotFoundException;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class CategoryDAOTest  {

    private static CategoryDAO categoryDAO;

    @BeforeEach
    public void setUp() {
        categoryDAO = new CategoryDAO();
    }
    @Disabled
    @Test
    public void testCreateCategory() {

        Category category = new Category("Java Basic");
        category = categoryDAO.create(category);

        assertTrue(category.getCategoryId() > 0 );
    }
    @Test
    public void testUpdateCategory(){
        Category newCategory = new Category(1,"Java");
        Category updatedCategory = categoryDAO.update(newCategory);


        assertEquals(newCategory.getName(),updatedCategory.getName());
    }
    @Test
    public  void testGetCategoryFound(){
        Integer categoryId =1;
        Category category = categoryDAO.get(categoryId);
        assertNotNull(category);
    }
    @Disabled
    @Test
    public void testDeleteCategory(){
        Integer categoryId =19;
        categoryDAO.delete(categoryId);
        Category category = categoryDAO.get(categoryId);

        assertNull(category);
    }
    @Test
    public void testDeleteCategoryNotFound(){
        Integer categoryId =6;
        assertThrows(EntityNotFoundException.class, () -> {
            categoryDAO.delete(categoryId);
        });
    }
    @Test
    public void testListAll(){
        List<Category> categories = categoryDAO.listAll();
        assertTrue(categories.size() > 0);
    }
    @Test
    public void testFindByName(){
        String categoryName = "Java";
        Category category = categoryDAO.findByName(categoryName);
        assertNotNull(category);
    }
    @Test
    public void testFindByNameNotFound(){
        String categoryName = "Java and Python";
        Category category = categoryDAO.findByName(categoryName);
        assertNull(category);
    }

    @Test
    public void testCount(){
        long count = categoryDAO.count();
        assertTrue(count > 0);
    }
    @AfterEach
    public void tearDown() {
        categoryDAO.close();
    }

}