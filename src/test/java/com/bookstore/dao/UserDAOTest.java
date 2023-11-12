package com.bookstore.dao;

import com.bookstore.entity.Users;
import org.junit.jupiter.api.*;
import javax.persistence.*;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

class UserDAOTest  {


    private static UserDAO userDAO;
    @BeforeEach
    public void setUp(){
        userDAO = new UserDAO();
    }

    @Test
    @Disabled
    public void testCreateUsers() {

        Users user1 = new Users();
        user1.setEmail("thanhdung1999@gmail.com");
        user1.setFullName("thanhdung");
        user1.setPassword("root");

        user1 = userDAO.create(user1);

        assertTrue(user1.getUserId() > 0 );
    }
    @Test
    public void testCreateUsersFieldsNotSet(){

        assertThrows(NullPointerException.class, () -> {
            Users user1 = new Users();
            user1 = userDAO.create(user1);
        });
    }
    @Test
    public void testUpdateUsers(){
        Users user1 = new Users();
        user1.setUserId(3);
        user1.setEmail("fdddddddds@gamil.com");
        user1.setFullName("dung");
        user1.setPassword("root1234");

        user1 = userDAO.update(user1);
        String expected = "root1234";
        String result = user1.getPassword();

        assertEquals(expected,result);
    }
    @Test
    public  void testGetUsersFound(){
        Integer userId =1;
        Users user = userDAO.get(userId);
        if (user != null){
            System.out.println(user.getEmail());
        }
        assertNotNull(user);
    }
    @Disabled
    @Test
    public void testDeleteUser(){
        Integer userId = 49;
        userDAO.delete(userId);
        Users user = userDAO.get(userId);
        assertNull(user);
    }
    @Test
    public void testDeleteUserNotFound(){
        Integer userId = 2;
        assertThrows(EntityNotFoundException.class, () -> {
            userDAO.delete(userId);
        });
    }
    @Test
    public void testListAll(){
        List<Users> usersList = userDAO.listAll();
        assertTrue(usersList.size() > 0);
    }
    @Test
    public void testFindByEmail(){
        String email = "";
        Users users = userDAO.findByEmail("fdddddddds@gamil.com");
        assertNotNull(users);
    }
    @Test
    public void testCheckLogin(){
        String email = "thanhdung1999@gmail.com";
        String password = "root";
        boolean isLogin = userDAO.checkLogin(email, password);
        assertTrue(isLogin);
    }
    @Test
    public void testCheckLoginFail(){
        String email = "fdddddddds@gamil.com";
        String password = "root123fff4";
        boolean isLogin = userDAO.checkLogin(email, password);
        assertFalse(isLogin);
    }
    @Test
    public void testCount(){
        long count = userDAO.count();
        assertTrue(count > 0);
    }
    @AfterEach
    public void tearDown() {
        userDAO.close();
    }

}