package ua.company.nedzelska.repository;

import org.springframework.data.repository.Repository;
import ua.company.nedzelska.domain.Customer;
import ua.company.nedzelska.domain.User;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by margarita on 01.09.15.
 */
public interface CustomerRepository extends Repository<Customer, Long>{

    List<Customer> findAll();

    Customer findCustomerById(Long id);

    @Transactional
    Customer save(Customer newCustomer);

    @Transactional
    void delete(Customer customer);

    Customer findCustomerByUser(User user);
}
