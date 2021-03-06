package ua.company.nedzelska.domain;

import java.util.Iterator;
import java.util.Map;

/**
 * Created by margarita on 04.09.15.
 */
public class PriceCalculator {

    public static double calc(Map<Meal, Integer> meals, double accumulativeSum) {
        if (meals == null || accumulativeSum < 0) {
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

            Meal meal = mealInOrder.next();

            total += amm * meal.getPrice();

        }

        if (accumulativeSum < 0.01) {
            return total;
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

        return truncate(total,2);

    }

    private static double truncate(double number, int precision) {
        double prec = Math.pow(10, precision);
        int integerPart = (int) number;
        double fractionalPart = number - integerPart;
        fractionalPart *= prec;
        int fractPart = (int) fractionalPart;
        fractionalPart = (double) (integerPart) + (double) (fractPart)/prec;
        return fractionalPart;
    }

    private PriceCalculator() {
    }
}
