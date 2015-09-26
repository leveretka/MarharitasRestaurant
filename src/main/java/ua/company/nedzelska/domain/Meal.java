package ua.company.nedzelska.domain;

import javax.persistence.*;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * Created by margarita on 01.09.15.
 */

@Entity
@Table(name = "MEALS")
public class Meal {

    @Id
    @GeneratedValue
    @Column(name = "MEAL_ID")
    private Long id;

    @NotNull
    @Column(name = "NAME")
    private String name;

    @NotNull
    @Min(value = 1)
    @Column(name = "MEAL_PRICE")
    private Double price;

    @NotNull
    @Min(value = 35)
    @Column(name = "OUT")
    private Double out;

    @NotNull
    @Column(name = "MEASURE_TYPE")
    @Enumerated(EnumType.STRING)
    private MeasureType measureType;

    @NotNull
    @Column(name = "MEAL_TYPE")
    @Enumerated(EnumType.STRING)
    private MealType mealType;

    @NotNull
    @Size(min = 2, max = 30)
    @Column(name = "NAME_UA")
    private String nameUa;

    public Meal() {
    }

    public Meal(String name, Double price, Double out, MeasureType measureType, MealType mealType) {
        this.name = name;
        this.price = price;
        this.out = out;
        this.measureType = measureType;
        this.mealType = mealType;
    }

    public String getNameUa() {
        return nameUa;
    }

    public void setNameUa(String nameUa) {
        this.nameUa = nameUa;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public Double getOut() {
        return out;
    }

    public void setOut(Double out) {
        this.out = out;
    }

    public MeasureType getMeasureType() {
        return measureType;
    }

    public void setMeasureType(MeasureType measureType) {
        this.measureType = measureType;
    }


    public void setMealType(MealType mealType) {
        this.mealType = mealType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public MealType getMealType() {
        return mealType;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Meal)) return false;

        Meal meal = (Meal) o;

        if (id.equals(meal.getId())) return true;

        if (mealType != meal.mealType) return false;
        if (measureType != meal.measureType) return false;
        if (name != null ? !name.equals(meal.name) : meal.name != null) return false;
        if (out != null ? !out.equals(meal.out) : meal.out != null) return false;
        if (price != null ? !price.equals(meal.price) : meal.price != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = name != null ? name.hashCode() : 0;
        result = 31 * result + (price != null ? price.hashCode() : 0);
        result = 31 * result + (out != null ? out.hashCode() : 0);
        result = 31 * result + (measureType != null ? measureType.hashCode() : 0);
        result = 31 * result + (mealType != null ? mealType.hashCode() : 0);
        return result;
    }

    public String getName(String locale) {
        if (locale.contains("uk")) {
            return getNameUa();
        }
        return  getName();
    }
}
