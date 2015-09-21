package ua.company.nedzelska.web;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * Created by margarita on 01.09.15.
 */
@Controller
@RequestMapping("/meal")
public class MealController extends AbstractController {

    private static final Logger logger = Logger.getLogger(MealController.class);

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String viewMenu(Model model) {

        model.addAttribute("meals", mealService.getAllMeals());

        return "menu";
    }

    @RequestMapping(value = "/{type}", method = RequestMethod.GET)
    public String viewMeals(Model model, @PathVariable(value = "type") String type) {

        if ("all".equals(type)) {
            model.addAttribute("meals", mealService.getAllMeals());
        } else {
            model.addAttribute("meals", mealService.getMeals(type));
        }
        return "menu";
    }


}
