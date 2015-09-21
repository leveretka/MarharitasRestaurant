package ua.company.nedzelska.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.company.nedzelska.domain.*;
import ua.company.nedzelska.repository.*;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by margarita on 03.09.15.
 */
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private AddressRepository addressRepository;
    @Autowired
    private ContactRepository contactRepository;
    @Autowired
    private AccumulativeCardRepository accumulativeCardRepository;

    @Override
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    @Override
    public Order placeNewOrder(HashMap<Meal, Integer> mealsInOrder, Date date, Customer customer, Address address, Contact contact) {

        Order order = new Order();

        Address addr = addressRepository.findByAreaAndDistrictAndCityAndStreetAndBuildingAndApartment(address.getArea(),
                address.getDistrict(), address.getCity(), address.getStreet(), address.getBuilding(), address.getApartment());

        if (addr != null) {
            order.setAddress(addr);
        } else {
            addressRepository.save(address);
            order.setAddress(address);
        }

        Contact cont = contactRepository.findByTelAndEmail(contact.getTel(), contact.getEmail());
        if (cont != null) {
            order.setContact(cont);
        } else {
            contactRepository.save(contact);
            order.setContact(contact);
        }

        order.setMeals(mealsInOrder);
        order.setCustomer(customer);
        order.calcPrice();
        order.setCustomer(customer);
        order.setDate(new Date());

        return orderRepository.save(order);

    }

    @Override
    public Order accept(Order o) {
        o.setStatus(Order.OrderStatus.ACCEPTED);
        return orderRepository.save(o);
    }

    @Override
    public Order cancel(Order o) {
        o.setStatus(Order.OrderStatus.CANCELLED);
        return orderRepository.save(o);
    }

    @Override
    public Order decline(Order o) {
        o.setStatus(Order.OrderStatus.DECLINED);
        return orderRepository.save(o);
    }

    @Override
    public Order deliver(Order o) {

        o.setStatus(Order.OrderStatus.DELIVERED);

        Customer customer = o.getCustomer();

        if (customer != null) {
            customer.getAccumulativeCard().add(o.getPrice());
            accumulativeCardRepository.save(customer.getAccumulativeCard());
        }

        return orderRepository.save(o);
    }

    @Override
    public Order getOrderById(Long id) {
        return orderRepository.findOrderById(id);
    }

    @Override
    public Order resend(Order order) {
        order.setStatus(Order.OrderStatus.NEW);
        order.setDate(new Date());
        return orderRepository.save(order);
    }
}
