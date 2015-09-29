package ua.company.nedzelska.domain;

import javax.persistence.*;
import javax.validation.constraints.Size;

/**
 * Created by margarita on 01.09.15.
 */
@Entity
@Table(name = "CUSTOMERS")
public class Customer {

    @Id
    @GeneratedValue
    @Column(name = "CUSTOMER_ID")
    private Long id;

    @Size(min = 2, message = "invalid_first_name")
    @Column(name = "FIRST_NAME")
    private String firstName;

    @Size(min = 2, message = "invalid_last_name")
    @Column(name = "LAST_NAME")
    private String lastName;

    @OneToOne
    @JoinColumn(name = "CONTACT_ID")
    private Contact contact;

    @OneToOne
    @JoinColumn(name = "ADDRESS_ID")
    private Address address;

    @OneToOne
    @JoinColumn(name = "ACCUMULATIVE_CARD_ID")
    private AccumulativeCard accumulativeCard;

    @OneToOne
    @JoinColumn(name = "USER_ID")
    private User user;

    public Customer() {
    }

    public Customer(String firstName, String lastName, Contact contact,
                    Address address, AccumulativeCard accumulativeCard, User user) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.contact = contact;
        this.address = address;
        this.accumulativeCard = accumulativeCard;
        this.user = user;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Contact getContact() {
        return contact;
    }

    public void setContact(Contact contact) {
        this.contact = contact;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public AccumulativeCard getAccumulativeCard() {
        return accumulativeCard;
    }

    public void setAccumulativeCard(AccumulativeCard accumulativeCard) {
        this.accumulativeCard = accumulativeCard;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
