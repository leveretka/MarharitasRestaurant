package ua.company.nedzelska.repository;

import org.springframework.data.repository.Repository;
import ua.company.nedzelska.domain.MealType;
import ua.company.nedzelska.domain.Meal;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by margarita on 01.09.15.
 */
public interface MealRepository extends Repository<Meal, Long> {

    List<Meal> findAll();

    List<Meal> findByMealType(MealType mealType);

    Meal findMealById(Long id);

    @Transactional
    Meal save(Meal newMeal);

    @Transactional
    void delete(Meal meal);
}
