package ua.company.nedzelska.repository;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.Repository;
import ua.company.nedzelska.domain.Order;
import ua.company.nedzelska.domain.Customer;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by margarita on 01.09.15.
 */


public interface OrderRepository extends Repository<Order, Long> {

    @Transactional
    Order save(Order order);

    @Transactional
    @Modifying
    @Query("update Order o set o.status = ?1 where o.id = ?2")
    Order setOrderStatusById(Order.OrderStatus status, Long id);

    List<Order> findAll();

    Order findOrderById(Long id);

    List<Order> findOrdersByCustomer(Customer customer);
}
