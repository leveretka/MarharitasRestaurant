package ua.company.nedzelska.service;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
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

    private static final Logger logger = Logger.getLogger(OrderServiceImpl.class);


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
    @Autowired
    private MailSender mailSender;
    @Autowired
    private SimpleMailMessage templateMessage;

    public void setMailSender(MailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void setTemplateMessage(SimpleMailMessage templateMessage) {
        this.templateMessage = templateMessage;
    }
    public void setMailSender(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    private String prepareText(Order order) {
        String name = order.getCustomer() == null? null : order.getCustomer().getUser().getName();
        String number = order.getId().toString();

        String result = name == null? "Thank" : "Dear " + name + ", thank";
        result += " you for placing order. Your order number is " + number + ".";

        return result;
    }

    private void sendMsg(Order order) {
        SimpleMailMessage msg = new SimpleMailMessage(this.templateMessage);
        msg.setTo(order.getContact().getEmail());
        msg.setText(prepareText(order));
        try{
            this.mailSender.send(msg);
        }
        catch(MailException ex) {
            logger.error(ex.getMessage());
        }
    }

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

        order = orderRepository.save(order);
        sendMsg(order);
        return order;

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

    public Order pay(Order o) {
        o.setStatus(Order.OrderStatus.PAYED);
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
