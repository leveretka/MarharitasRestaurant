package ua.company.nedzelska.service;

import ua.company.nedzelska.domain.Meal;

import java.util.List;

/**
 * Created by margarita on 01.09.15.
 */
public interface MealService {
    List<Meal> getAllMeals();

    List<Meal> getMeals(String type);

    Meal getMealById(Long id);

    Long addMeal(Meal newMeal);

    void remove(Meal meal);
}
