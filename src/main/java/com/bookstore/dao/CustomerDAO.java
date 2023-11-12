package com.bookstore.dao;

import com.bookstore.entity.Customer;
import com.bookstore.entity.Users;


import java.sql.Date;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CustomerDAO extends JpaDAO<Customer> implements GenericDAO<Customer>{

    @Override
    public Customer create(Customer customer) {
        String encryptedPassword = HashGenerator.generateMD5(customer.getPassword());
        customer.setPassword(encryptedPassword);
        customer.setRegisterDate(new Date(Calendar.getInstance().getTimeInMillis()));
        return super.create(customer);
    }

    @Override
    public Customer update(Customer customer) {
        return super.update(customer);
    }


    @Override
    public Customer get(Object customerId) {
        return super.find(Customer.class, customerId);
    }

    @Override
    public void delete(Object customerId) {
        super.delete(Customer.class, customerId);
    }

    @Override
    public List<Customer> listAll() {
        return super.findWithNamedQuery("Customer.findAll");
    }

    @Override
    public long count() {
        return super.countWithNamedQuery("Customer.countAll");
    }

    public Customer findByEmail(String email){
        List<Customer> listResults = super.findWithNamedQuery("Customer.findByEmail", "email", email);
        if (listResults != null && listResults.size() > 0 ){
            return listResults.get(0);
        }
        return null;
    }
    public Customer checkLogin(String email, String password){
        Map<String, Object> parameters = new HashMap<>();
        String encryptedPassword = HashGenerator.generateMD5(password);
        parameters.put("email", email);
        parameters.put("password", encryptedPassword);
        List<Customer> customersList = super.findWithNamedQuery("Customer.checkLogin",parameters);
        if (customersList.size() == 1)
        {
            return customersList.get(0);
        }
        else {
            return null;
        }
    }
    public Customer changePassword(Customer customer, String newPassword){
        String encryptedPassword = HashGenerator.generateMD5(newPassword);
        customer.setPassword(encryptedPassword);
        return super.update(customer);
    }
}
