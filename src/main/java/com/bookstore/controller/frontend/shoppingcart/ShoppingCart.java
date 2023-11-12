package com.bookstore.controller.frontend.shoppingcart;

import com.bookstore.entity.Book;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class ShoppingCart {

    private Map<Book, Integer> items = new HashMap<>();
    private int totalItems;
    private int totalQuantity;
    private float totalAmount;

    public int getTotalItems() {
        return items.size();
    }

    public int getTotalQuantity() {
        int total = 0;
        Iterator<Book> iterator = items.keySet().iterator();
        while (iterator.hasNext()){
            Book next = iterator.next();
            Integer quantity = items.get(next);
            total += quantity;
        }
        return total;
    }

    public float getTotalAmount() {
        float total = 0.0f;
        Iterator<Book> iterator = items.keySet().iterator();
        while (iterator.hasNext()){
            Book book = iterator.next();
            Integer quantity = items.get(book);
            double subTotal = quantity * book.getPrice();
            total += subTotal;
        }
        return total;
    }

    public Map<Book, Integer> getItems() {
        return items;
    }

    public void addItem(Book book){
        if (items.containsKey(book)){
            Integer quantity = items.get(book) + 1;
            items.put(book, quantity);
        }else {
            items.put(book, 1);
        }
    }

    public void removeItem(Book book){
        items.keySet().removeIf(b -> b.getBookId() == book.getBookId());
    }
    public void updateCart(int[] bookIds, int[] quantities){
        for (int i = 0; i < bookIds.length; i++){
            int bookId =  bookIds[i];
            Book key =  items.keySet().stream()
                    .filter(book -> book.getBookId() == bookId)
                    .findFirst().orElse(null);
            if (key != null){
                Integer value = quantities[i];
                items.put(key, value);
            }
        }
    }


    public void clear(){
        items.clear();
    }
}
