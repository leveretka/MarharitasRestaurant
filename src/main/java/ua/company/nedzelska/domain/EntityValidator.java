package ua.company.nedzelska.domain;

import org.springframework.stereotype.Component;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * Created by margarita on 9/26/15.
 */
@Component
public class EntityValidator {

    private Validator validator;

    public EntityValidator() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    private <T> List<String> validate(T object) {
        Set<ConstraintViolation<T>> constraintViolations = validator.validate(object);
        List<String> result = new ArrayList<>();
        for (Iterator<ConstraintViolation<T>> iterator = constraintViolations.iterator(); iterator.hasNext();) {
            result.add(iterator.next().getMessage());
        }
        return result;
    }

    public List<String> validate (Customer customer, User user, Contact contact, Address address) {

        List<String> result = new ArrayList<>();

        result.addAll(validate(customer));
        result.addAll(validate(user));
        result.addAll(validate(contact));
        result.addAll(validate(address));

        return result;

    }

    public List<String> validate (Contact contact, Address address) {

        List<String> result = new ArrayList<>();

        result.addAll(validate(contact));
        result.addAll(validate(address));

        return result;

    }
}
