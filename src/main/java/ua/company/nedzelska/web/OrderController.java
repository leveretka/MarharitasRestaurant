package ua.company.nedzelska.web;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import ua.company.nedzelska.domain.*;
import ua.company.nedzelska.service.CustomerService;
import ua.company.nedzelska.service.OrderService;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by margarita on 04.09.15.
 */
@Controller
@RequestMapping("/order")
@SessionAttributes({"mealsInOrder"})
public class OrderController extends AbstractController{

    private static final Logger logger = Logger.getLogger(OrderController.class);

    @Autowired
    private OrderService orderService;
    @Autowired
    private CustomerService customerService;
    @Autowired
    private EntityValidator entityValidator;

    @ModelAttribute("mealsInOrder")
    public HashMap<Meal, Integer> populateMealsInOrder() {
        return new HashMap<>();
    }

    @RequestMapping(value = "/addmeal", method = RequestMethod.POST)
    public String addMealToCart(@RequestParam("mealid") Meal meal, HttpServletRequest request, @ModelAttribute("mealsInOrder") HashMap<Meal, Integer> mealsInOrder, Model model) {

        String s = request.getHeader("Referer");

        if (s.contains("submitorder")) {
            s = "/jsp/order/previewOrder";
        }

        if  (mealsInOrder == null) {
            mealsInOrder = new HashMap<>();
        }
        if (mealsInOrder.containsKey(meal)) {
            mealsInOrder.replace(meal, mealsInOrder.get(meal) + 1);
        } else {
            mealsInOrder.put(meal, 1);
        }

        model.addAttribute("mealsInOrder", mealsInOrder);

        return "redirect:" + s;
    }

    @RequestMapping(value = "/previewOrder", method = RequestMethod.POST)
    public String previewOrder(@ModelAttribute("mealsInOrder") HashMap<Meal, Integer> mealsInOrder, Model model) {


        Authentication authentication =  SecurityContextHolder.getContext().getAuthentication();
        String name = authentication.getName();
        Customer customer = customerService.getCustomerByUserName(name);

        //Order order = orderService.placeNewOrder(customer, pizzasInOrder);

        Address address = customer == null? null : customer.getAddress();
        Contact contact = customer == null? null : customer.getContact();

        Order order = new Order(mealsInOrder, new Date(), customer, address, contact);
        order.calcPrice();

        model.addAttribute("order", order);
        return "bucket";

    }

    @RequestMapping(value = "/removemeal", method = RequestMethod.POST)
    public String removePizzaFromOrder(@ModelAttribute("mealsInOrder") HashMap<Meal, Integer> mealsInOrder, Model model, @RequestParam("mealid") Meal meal) {

        if (mealsInOrder.containsKey(meal)) {
            if (mealsInOrder.get(meal) > 1) {
                mealsInOrder.replace(meal, mealsInOrder.get(meal) - 1);
            } else {
                mealsInOrder.remove(meal);
            }
        }

        model.addAttribute("mealsInOrder", mealsInOrder);
        return "redirect:/jsp/order/previewOrder";

    }

    @RequestMapping(value = "/previewOrder", method = RequestMethod.GET)
    public String preview(@ModelAttribute("mealsInOrder") HashMap<Meal, Integer> mealsInOrder, Model model) {

        Authentication authentication =  SecurityContextHolder.getContext().getAuthentication();
        String name = authentication.getName();
        Customer customer = customerService.getCustomerByUserName(name);

        //Order order = orderService.placeNewOrder(customer, pizzasInOrder);

        Address address = customer == null? null : customer.getAddress();
        Contact contact = customer == null? null : customer.getContact();

        Order order = new Order(mealsInOrder, new Date(), customer, address, contact);
        order.calcPrice();

        model.addAttribute("order", order);
        return "bucket";

    }

    @RequestMapping(value = "/submitorder", method = RequestMethod.POST)
    public String submitOrder(@ModelAttribute Contact contact, @ModelAttribute Address address,@ModelAttribute("mealsInOrder") HashMap<Meal, Integer> mealsInOrder, Model model) {

        List<String> errors = entityValidator.validate(contact, address);
        if (errors.size() != 0) {

            Authentication authentication =  SecurityContextHolder.getContext().getAuthentication();
            String name = authentication.getName();
            Customer customer = customerService.getCustomerByUserName(name);


            Order order = new Order(mealsInOrder, new Date(), customer, address, contact);
            order.calcPrice();

            model.addAttribute("order", order);
            model.addAttribute("errors", errors);
            return "bucket";

        }
        Authentication authentication =  SecurityContextHolder.getContext().getAuthentication();
        String name = authentication.getName();
        Customer customer = customerService.getCustomerByUserName(name);

        Order order = orderService.placeNewOrder(mealsInOrder, new Date(), customer, address, contact);

        model.addAttribute("meals", mealService.getAllMeals());
        model.addAttribute("mealsInOrder", new HashMap<>());
        return "ordersuccess";

    }


    @RequestMapping(value = "/cancelorder", method = RequestMethod.POST)
    public String cancelOrder(@RequestParam("orderid") Order order, Model model) {
        if (!order.getStatus().equals(Order.OrderStatus.DELIVERED)) {
            orderService.cancel(order);
        }
        model.addAttribute("orders", orderService.getAllOrders());
        return "redirect:/jsp/cust/cabinet";

    }

    @RequestMapping(value = "/resendorder", method = RequestMethod.POST)
    public String resendOrder(@RequestParam("orderid") Order order, Model model) {
        if (order.getStatus().equals(Order.OrderStatus.DECLINED) || order.getStatus().equals(Order.OrderStatus.CANCELLED)) {
            orderService.resend(order);
        }
        model.addAttribute("orders", orderService.getAllOrders());
        return "redirect:/jsp/cust/cabinet";

    }

    @RequestMapping(value = "/payorder", method = RequestMethod.POST)
    public String payOrder(@RequestParam("orderid") Order order, Model model) {
        if (order.getStatus().equals(Order.OrderStatus.ACCEPTED)) {
            orderService.pay(order);
        }
        model.addAttribute("orders", orderService.getAllOrders());
        return "redirect:/jsp/cust/cabinet";

    }
    @Secured("ROLE_USER")
    @RequestMapping(value = "/{orderid}", method = RequestMethod.GET)
    public String detailOrder(@PathVariable("orderid") Long id, Model model) {

        Order order = orderService.getOrderById(id);

        Authentication authentication =  SecurityContextHolder.getContext().getAuthentication();
        String name = authentication.getName();
        Customer customer = customerService.getCustomerByUserName(name);

        if (order == null || order.getCustomer() == null || !customer.getId().equals(order.getCustomer().getId())) {
            return "error403";
        }

        model.addAttribute("order", order);
        return "order";

    }

}
