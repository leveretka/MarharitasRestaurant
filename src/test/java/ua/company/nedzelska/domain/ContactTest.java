package ua.company.nedzelska.domain;

import org.junit.BeforeClass;
import org.junit.Test;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import java.util.Set;

import static org.junit.Assert.assertEquals;

/**
 * Created by margarita on 9/26/15.
 */
public class ContactTest {

    private static Validator validator;

    @BeforeClass
    public static void setUp() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }


    @Test
    public void createContactWithWrongMail() {
        Contact c = new Contact("+380664037070", "qwe");

        Set<ConstraintViolation<Contact>> constraintViolations = validator.validate(c);

        assertEquals(1, constraintViolations.size());

        System.out.println(constraintViolations.iterator().next().getMessage());

    }

    @Test
    public void createContactWithWrongTelephone() {
        Contact c = new Contact("asd56", "margoqueen95@gmail.com");

        Set<ConstraintViolation<Contact>> constraintViolations = validator.validate(c);

        assertEquals(1, constraintViolations.size());

        System.out.println(constraintViolations.iterator().next().getMessage());

    }
}
