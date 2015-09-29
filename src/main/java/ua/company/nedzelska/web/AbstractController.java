package ua.company.nedzelska.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import ua.company.nedzelska.domain.Order;
import ua.company.nedzelska.service.CustomerService;
import ua.company.nedzelska.service.OrderService;
import ua.company.nedzelska.domain.Customer;
import ua.company.nedzelska.domain.Meal;
import ua.company.nedzelska.service.MealService;

import java.beans.PropertyEditorSupport;

/**
 * Created by margarita on 04.09.15.
 */
public abstract class AbstractController {

    @Autowired
    protected MealService mealService;
    @Autowired
    protected OrderService orderService;
    @Autowired
    protected CustomerService customerService;

    @InitBinder
    protected void mealBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Meal.class,
                new PropertyEditorSupport() {

                    @Override
                    public void setAsText(String mealId) {
                        Meal meal = null;
                        if (mealId != null && !mealId.trim().isEmpty()) {
                            Long id = Long.parseLong(mealId.trim());
                            meal = getMealById(id);
                        }
                        setValue(meal);
                    }
                });
    }

    protected Meal getMealById(Long id) {
        if (id<=0) throw new IllegalArgumentException("ID<0");
        Meal meal = mealService.getMealById(id);
        if (meal == null)
            throw new NotFoundMealException("Meal id" + id + " not found" );
        return meal;

    }
    @InitBinder
    protected void orderBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Order.class,
                new PropertyEditorSupport() {

                    @Override
                    public void setAsText(String orderId) {
                        Order order = null;
                        if (orderId != null && !orderId.trim().isEmpty()) {
                            Long id = Long.parseLong(orderId.trim());
                            order = getOrderById(id);
                        }
                        setValue(order);
                    }
                });
    }

    protected Order getOrderById(Long id) {
        if (id<=0) throw new IllegalArgumentException("ID<0");
        Order order = orderService.getOrderById(id);
        if (order == null) {
            throw new NotFoundOrderException("Meal id" + id + " not found");
        }
        return order;

    }

    @InitBinder
    protected void customerBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Customer.class,
                new PropertyEditorSupport() {

                    @Override
                    public void setAsText(String custid) {
                        Customer customer = null;
                        if (custid != null && !custid.trim().isEmpty()) {
                            Long id = Long.parseLong(custid.trim());
                            customer = getCustomerById(id);
                        }
                        setValue(customer);
                    }
                });
    }

    protected Customer getCustomerById(Long id) {
        if (id<=0) throw new IllegalArgumentException("ID<0");
        Customer customer = customerService.getCustomerById(id);
        if (customer == null)
            throw new NotFoundCustomerException("Customer id" + id + " not found" );
        return customer;

    }

}
