package ua.company.nedzelska.domain;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import javax.persistence.*;
import java.util.Date;
import java.util.Map;

import static ua.company.nedzelska.domain.PriceCalculator.calc;

/**
 * Created by margarita on 01.09.15.
 */
@Component
@Scope(value = "prototype")
@Entity
@Table(name = "ORDERS")
public class Order {

    @Id
    @GeneratedValue
    @Column(name = "ORDER_ID")
    private Long id;

    @ElementCollection
    @JoinTable(name="ORDER_MEALS", joinColumns=@JoinColumn(name="ORDER_ID"))
    @MapKeyColumn(name="MEAL_ID")
    @Column(name="QUANTITY")
    private Map<Meal, Integer> meals;

    @Column(name = "ORDER_PRICE")
    private Double price;

    @Temporal(value = TemporalType.TIMESTAMP)
    @Column(name = "ORDER_DATE")
    private Date date;

    @ManyToOne
    @JoinColumn(name = "CUSTOMER_ID")
    private Customer customer;

    @OneToOne
    @JoinColumn(name = "ADDRESS_ID")
    private Address address;

    @OneToOne
    @JoinColumn(name = "CONTACT_ID")
    private Contact contact;

    @Enumerated(EnumType.STRING)
    @Column(name = "STATUS")
    private OrderStatus status;

    public Order() {
        this.status = OrderStatus.NEW;
    }

    public Order(Map<Meal, Integer> meals, Date date, Customer customer, Address address, Contact contact) {
        this.meals = meals;
        this.date = date;
        this.customer = customer;
        this.address = address;
        this.contact = contact;
        this.status = OrderStatus.NEW;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Map<Meal, Integer> getMeals() {
        return meals;
    }

    public void setMeals(Map<Meal, Integer> meals) {
        this.meals = meals;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public Contact getContact() {
        return contact;
    }

    public void setContact(Contact contact) {
        this.contact = contact;
    }

    public void calcPrice() {
        double accumulatedSum = customer == null? 0.0 :  customer.getAccumulativeCard().getSum();
        price = calc(meals, accumulatedSum);
    }

    public static enum OrderStatus {
        NEW,
        ACCEPTED,
        CANCELLED,
        DECLINED,
        DELIVERED
    }

    public OrderStatus getStatus() {
        return status;
    }

    public void setStatus(OrderStatus status) {
        this.status = status;
    }
}
