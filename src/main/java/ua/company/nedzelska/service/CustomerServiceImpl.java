package ua.company.nedzelska.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.company.nedzelska.domain.*;
import ua.company.nedzelska.repository.*;

import java.util.List;

/**
 * Created by margarita on 03.09.15.
 */
@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private AccumulativeCardRepository accumulativeCardRepository;

    @Autowired
    private AddressRepository addressRepository;

    @Autowired
    private ContactRepository contactRepository;

    @Autowired
    private UserRepository userRepository;

    @Override
    public List<Customer> getAllCustomers() {
        return customerRepository.findAll();
    }

    @Override
    public void remove(Customer customer) {
        customerRepository.delete(customer);
    }

    @Override
    public void addCustomer(Customer newCustomer) {

        accumulativeCardRepository.save(newCustomer.getAccumulativeCard());
        contactRepository.save(newCustomer.getContact());
        addressRepository.save(newCustomer.getAddress());
        userRepository.save(newCustomer.getUser());

        customerRepository.save(newCustomer);


    }

    @Override
    public void addCustomer(Customer newCustomer, AccumulativeCard accumulativeCard, Address address, Contact contact, User user) {

        accumulativeCardRepository.save(accumulativeCard);

        Contact cont = contactRepository.findByTelAndEmail(contact.getTel(), contact.getEmail());
        Address addr = addressRepository.findByAreaAndDistrictAndCityAndStreetAndBuildingAndApartment(address.getArea(),
                address.getDistrict(), address.getCity(), address.getStreet(), address.getBuilding(),
                address.getApartment());

        if (cont != null) {
            contact.setId(cont.getId());
        }

        if (addr != null) {
            address.setId(addr.getId());
        }

        contactRepository.save(contact);
        addressRepository.save(address);
        userRepository.save(user);

        newCustomer.setContact(contact);
        newCustomer.setAddress(address);
        newCustomer.setAccumulativeCard(accumulativeCard);
        newCustomer.setUser(user);


        customerRepository.save(newCustomer);

    }


    @Override
    public Customer getCustomerById(Long id) {
        return customerRepository.findCustomerById(id);
    }

    @Override
    public Customer getCustomerByUserName(String name) {
        User user = userRepository.findUserByName(name);
        Customer customer = customerRepository.findCustomerByUser(user);
        return customer;
    }
}
