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
    @Autowired
    private UserRoleRepository userRoleRepository;

    @Override
    public List<Customer> getAllCustomers() {
        return customerRepository.findAll();
    }

    @Override
    public void remove(Customer customer) {
        AccumulativeCard accumulativeCard = customer.getAccumulativeCard();
        User user = customer.getUser();
        customerRepository.delete(customer);
        accumulativeCardRepository.delete(accumulativeCard);
        List<UserRole> roles = userRoleRepository.findUserRolesByUserId(user.getId());
        for (UserRole role: roles) {
            userRoleRepository.delete(role);
        }
        userRepository.delete(user);
    }

    @Override
    public void addCustomer(Customer newCustomer) {

        if (newCustomer.getAccumulativeCard().getId() == null) {
            newCustomer.getAccumulativeCard().setSum(0.0);
        }

        accumulativeCardRepository.save(newCustomer.getAccumulativeCard());
        contactRepository.save(newCustomer.getContact());
        addressRepository.save(newCustomer.getAddress());
        if (newCustomer.getUser().getId() == null) {
            userRepository.save(newCustomer.getUser());
            userRoleRepository.save(new UserRole(newCustomer.getUser(), Authority.ROLE_USER));
        } else {
            userRepository.save(newCustomer.getUser());
        }

        customerRepository.save(newCustomer);


    }

    @Override
    public void addCustomer(Customer newCustomer, AccumulativeCard accumulativeCard, Address address, Contact contact, User user) {

        if (accumulativeCard.getId() == null) {
            accumulativeCard.setSum(0.0);
        }
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

        if (user.getId() == null) {
            userRoleRepository.save(new UserRole(user, Authority.ROLE_USER));
        }

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
