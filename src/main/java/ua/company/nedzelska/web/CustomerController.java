package ua.company.nedzelska.web;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import ua.company.nedzelska.domain.*;
import ua.company.nedzelska.repository.OrderRepository;
import ua.company.nedzelska.service.CustomerService;

import java.util.List;

/**
 * Created by margarita on 03.09.15.
 */
@Controller
@RequestMapping("/cust")
@SessionAttributes({"customer"})
public class CustomerController {

    private static final Logger logger = Logger.getLogger(CustomerController.class);


    @Autowired
    private CustomerService customerService;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private EntityValidator registrationValidator;


    @ModelAttribute("customer")
    public Customer populateCustomer() {
        return new Customer();
    }


    @RequestMapping(value = "/addnew", method = RequestMethod.POST)
    public String register(@ModelAttribute Customer newCustomer, @ModelAttribute Contact contact,
                           @ModelAttribute Address address, @ModelAttribute AccumulativeCard accumulativeCard,
                           @ModelAttribute User user, @ModelAttribute("customer") Customer customer, Model model) {

        List<String> errors = registrationValidator.validate(newCustomer, user, contact, address);

        if (customer != null && customer.getId() != null) {

            accumulativeCard.setId(customer.getAccumulativeCard().getId());
            address.setId(customer.getAddress().getId());
            contact.setId(customer.getContact().getId());
            user.setId(customer.getUser().getId());

            newCustomer.setId(customer.getId());

            if (errors.size() != 0) {
                model.addAttribute("errors", errors);
                model.addAttribute("customer", customer);
                model.addAttribute("orders", orderRepository.findOrdersByCustomer(customer));
                return "cabinet";
            }

        } else if (errors.size() != 0) {
            model.addAttribute("errors", errors);
            return "registration";
        }

        newCustomer.setAccumulativeCard(accumulativeCard);
        newCustomer.setAddress(address);
        newCustomer.setContact(contact);
        newCustomer.setUser(user);

        customerService.addCustomer(newCustomer);

        model.addAttribute("customer", newCustomer);

        return "redirect:/";
    }

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String register() {
        return "registration";
    }

    @Secured("ROLE_USER")
    @RequestMapping(value = "/cabinet", method = RequestMethod.GET)
    public String getCustomerInfo(@ModelAttribute("customer") Customer customer, Model model) {

        if (customer == null || customer.getId() == null) {
            Authentication authentication =  SecurityContextHolder.getContext().getAuthentication();
            String name = authentication.getName();
            customer = customerService.getCustomerByUserName(name);
        }

        model.addAttribute("customer", customer);
        model.addAttribute("orders", orderRepository.findOrdersByCustomer(customer));
        return "cabinet";
    }

}
