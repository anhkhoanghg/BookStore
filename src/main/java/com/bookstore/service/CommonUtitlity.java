package com.bookstore.service;

import com.bookstore.store.Message;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

public class CommonUtitlity {
    public static void forwardToPage(String page, Message message, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("message", message);
        request.getRequestDispatcher(page).forward(request, response);
    }
    public static void forwardToPage(String page, HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher(page).forward(request, response);
    }
    public static Map<String, String> mapCountries(){
        String[] countryCodes = Locale.getISOCountries();
        Map<String, String> mapCountries = new HashMap<>();

        for (String countryCode:countryCodes){
            Locale locale = new Locale("",countryCode);
            String code = locale.getCountry();
            String name = locale.getDisplayCountry();

            mapCountries.put(name, code);
        }
        Map<String, String> sortedMapCountries = mapCountries.entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue, (e1, e2) -> e1, LinkedHashMap::new));
        return sortedMapCountries;
    }
    public static String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

}
