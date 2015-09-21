package ua.company.nedzelska.service;

import ua.company.nedzelska.domain.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by margarita on 01.09.15.
 */
public interface OrderService {

    List<Order> getAllOrders();

    Order placeNewOrder(HashMap<Meal, Integer> mealsInOrder, Date date, Customer customer, Address address, Contact contact);

    Order accept (Order o);

    Order cancel (Order o);

    Order decline (Order o);

    Order deliver (Order o);

    Order getOrderById(Long id);

    Order resend(Order order);
}
