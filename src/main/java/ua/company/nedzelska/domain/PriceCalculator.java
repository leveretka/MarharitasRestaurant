package ua.company.nedzelska.domain;

import java.util.Iterator;
import java.util.Map;

/**
 * Created by margarita on 04.09.15.
 */
public class PriceCalculator {

    public static double calc(Map<Meal, Integer> meals, double accumulativeSum) {
        if (meals == null || meals.size() == 0 || accumulativeSum < 0) {
            throw new IllegalArgumentException();
        }

        Iterator<Integer> amount = meals.values().iterator();
        Iterator<Meal> mealInOrder = meals.keySet().iterator();

        double total = 0;
        int totalQnt = 0;

        while (amount.hasNext()) {

            Integer amm = amount.next();
            if (amm <= 0) {
                throw new NumberFormatException();
            }

            totalQnt += amm;
            if (totalQnt > 10) {
                throw new IllegalArgumentException();
            }

            Meal meal = mealInOrder.next();

            total += amm * meal.getPrice();

        }

        if (accumulativeSum < 1000) {
            total *= 0.99;
        } else if (accumulativeSum < 2000) {
            total *= 0.97;
        } else if (accumulativeSum < 5000) {
            total *= 0.95;
        } else if (accumulativeSum < 10000) {
            total *= 0.93;
        } else if (accumulativeSum < 20000) {
            total *= 0.9;
        } else {
            total *= 0.8;
        }

        return total;

    }

    private PriceCalculator() {
    }
}
