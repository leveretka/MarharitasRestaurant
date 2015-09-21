package ua.company.nedzelska.web;

import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import ua.company.nedzelska.domain.*;
import org.apache.log4j.Logger;

/**
 * Created by margarita on 03.09.15.
 */
@Controller
@RequestMapping("/admin")
public class AdminController extends AbstractController{

    private static final Logger logger = Logger.getLogger(AdminController.class);

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String administrate () {
        return "adminpanel";
    }


    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/admintype", method = RequestMethod.POST)
    public String switchAdminType(Model model, @RequestParam String type) {

        switch (type) {

            case "MEALS":
                return "redirect:meal/";

            case "CUSTOMERS":
                return "redirect:cust/";

            case "ORDERS":
                return "redirect:order/";

        }
        return "redirect:";

    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/meal/", method = RequestMethod.GET)
    public String viewMeals(Model model) {

        model.addAttribute("meals", mealService.getAllMeals());

        return "meals";
    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/meal/editmeal", method = RequestMethod.POST)
    public String editMeals(Model model, @RequestParam("mealid") Meal meal) {
        model.addAttribute("types", MealType.values());
        model.addAttribute("measures", MeasureType.values());
        model.addAttribute("meal", meal);
        return "newmeal";
    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/meal/removemeal", method = RequestMethod.POST)
    public String removeMeals(Model model, @RequestParam("mealid") Meal meal) {
        model.addAttribute("types", MealType.values());
        model.addAttribute("measures", MeasureType.values());
        mealService.remove(meal);
        model.addAttribute("meals", mealService.getAllMeals());
        return "meals";
    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/meal/addnew", method = RequestMethod.POST)
    public String addNewMeal(@ModelAttribute Meal newMeal, Model model) {
        mealService.addMeal(newMeal);
        model.addAttribute("meals", mealService.getAllMeals());
        return "meals";
    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/meal/create", method = RequestMethod.GET)
    public String createMeal(Model model) {
        model.addAttribute("types", MealType.values());
        model.addAttribute("measures", MeasureType.values());
        return "newmeal";
    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/order/", method = RequestMethod.GET)
    public String viewOrders(Model model) {
        model.addAttribute("orders", orderService.getAllOrders());
        return "orders";
    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/order/acceptorder", method = RequestMethod.POST)
    public String submitOrder(@RequestParam("orderid") Order order, Model model) {
        if (order.getStatus().equals(Order.OrderStatus.NEW)) {
            orderService.accept(order);
            logger.info("Accepted order #" + order.getId() + ".");
        } else {
            logger.info("Attempted to accept not new order.");
        }
        model.addAttribute("orders", orderService.getAllOrders());
        return "redirect:";

    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/order/declineorder", method = RequestMethod.POST)
    public String declineOrder(@RequestParam("orderid") Order order, Model model) {
        if (order.getStatus().equals(Order.OrderStatus.NEW)) {
            orderService.decline(order);
            logger.info("Declined order #" + order.getId() + ".");
        } else {
            logger.info("Attempted to decline not new order.");
        }
        model.addAttribute("orders", orderService.getAllOrders());
        return "redirect:";

    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/order/deliverorder", method = RequestMethod.POST)
    public String deliverOrder(@RequestParam("orderid") Order order, Model model) {
        if (order.getStatus().equals(Order.OrderStatus.ACCEPTED)) {
            orderService.deliver(order);
            logger.info("Delivered order #" + order.getId() + ".");
        } else {
            logger.info("Attempted to deliver not accepted order.");
        }
        model.addAttribute("orders", orderService.getAllOrders());
        return "redirect:";

    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/cust", method =RequestMethod.GET)
    public String viewCustomers(Model model) {
        model.addAttribute("customers", customerService.getAllCustomers());
        return "customers";
    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/cust/editcust", method = RequestMethod.POST)
    public String editCustomer(Model model, @RequestParam("custid") Customer customer) {
        model.addAttribute("customer", customer);
        return "newcust";
    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/cust/removecust", method = RequestMethod.POST)
    public String removeCustomer(Model model, @RequestParam("custid") Customer customer) {
        customerService.remove(customer);
        model.addAttribute("customers", customerService.getAllCustomers());
        return "customers";
    }

    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/cust/addcust", method = RequestMethod.POST)
    public String addNewCustomer(@ModelAttribute Customer newCustomer, @ModelAttribute Contact contact,
                                 @ModelAttribute Address address, @ModelAttribute AccumulativeCard accumulativeCard,
                                 @ModelAttribute User user, Model model) {

        Customer old = customerService.getCustomerById(newCustomer.getId());

        if (old != null) {
            accumulativeCard.setId(old.getAccumulativeCard().getId());
            address.setId(old.getAddress().getId());
            contact.setId(old.getContact().getId());
            user.setId(old.getUser().getId());
        } else {
            logger.info("Saving new customer " + user.getName() + ".");
        }

        newCustomer.setAccumulativeCard(accumulativeCard);
        newCustomer.setAddress(address);
        newCustomer.setContact(contact);
        newCustomer.setUser(user);

        customerService.addCustomer(newCustomer);
        model.addAttribute("customers", customerService.getAllCustomers());
        return "customers";
    }


    @Secured("ROLE_ADMIN")
    @RequestMapping(value = "/cust/create", method = RequestMethod.GET)
    public String createCustomer(Model model) {
        return "newcust";
    }

}
