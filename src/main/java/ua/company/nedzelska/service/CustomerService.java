package ua.company.nedzelska.service;

import ua.company.nedzelska.domain.*;

import java.util.List;

/**
 * Created by margarita on 03.09.15.
 */
public interface CustomerService {
    List<Customer> getAllCustomers();

    void remove(Customer customer);

    void addCustomer(Customer newCustomer);

    Customer getCustomerById(Long id);

    Customer getCustomerByUserName(String name);

    void addCustomer(Customer newCustomer, AccumulativeCard accumulativeCard, Address address, Contact contact, User user);
}
