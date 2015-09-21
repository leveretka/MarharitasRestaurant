package ua.company.nedzelska.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ua.company.nedzelska.domain.Meal;
import ua.company.nedzelska.domain.MealType;
import ua.company.nedzelska.repository.MealRepository;

import java.util.List;

/**
 * Created by margarita on 01.09.15.
 */
@Service
public class MealServiceImpl implements MealService {

    @Autowired
    private MealRepository mealRepository;

    @Override
    public List<Meal> getAllMeals() {
        return mealRepository.findAll();
    }

    @Override
    public List<Meal> getMeals(String type) {
        return mealRepository.findByMealType(MealType.valueOf(type.toUpperCase()));
    }

    @Override
    public Meal getMealById(Long id) {
        return mealRepository.findMealById(id);
    }

    @Override
    public Long addMeal(Meal newMeal) {
            return mealRepository.save(newMeal)
                    .getId();
    }

    @Override
    public void remove(Meal meal) {
        mealRepository.delete(meal);
    }
}
