package com.bookstore.dao;

import com.bookstore.entity.Users;

import javax.persistence.EntityManager;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserDAO extends JpaDAO<Users> implements GenericDAO<Users>{

    public UserDAO() {

    }

    @Override
    public Users create(Users user) {
        String encryptedPassword = HashGenerator.generateMD5(user.getPassword());
        user.setPassword(encryptedPassword);
        return super.create(user);
    }

    @Override
    public Users update(Users user) {
        return super.update(user);
    }

    @Override
    public Users get(Object userId) {
        return super.find(Users.class, userId);
    }

    @Override
    public void delete(Object userId) {
        super.delete(Users.class, userId);
    }

    @Override
    public List<Users> listAll() {
        return super.findWithNamedQuery("Users.findAll");
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Users.countAll");
    }

    public Users findByEmail(String email){
        List<Users> listResults = super.findWithNamedQuery("Users.findByEmail", "email", email);
        if (listResults != null && listResults.size() > 0 ){
            return listResults.get(0);
        }
        return null;
    }
    public boolean checkLogin(String email, String password){
        Map<String, Object> parameters = new HashMap<>();
        String encryptedPassword = HashGenerator.generateMD5(password);
        parameters.put("email",email);
        parameters.put("password",encryptedPassword);
        List<Users> usersList = super.findWithNamedQuery("Users.checkLogin",parameters);
        if (usersList.size() == 1)
        {
            return true;
        }
        else {
            return false;
        }
    }
}
