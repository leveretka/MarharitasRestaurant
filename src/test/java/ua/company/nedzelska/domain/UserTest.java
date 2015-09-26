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
public class UserTest {

    private static Validator validator;

    @BeforeClass
    public static void setUp() {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        validator = factory.getValidator();
    }

    @Test
    public void createUserNullName() {

        User user = new User(null,"111", Boolean.TRUE);

        Set<ConstraintViolation<User>> constraintViolations = validator.validate(user);

        assertEquals(1, constraintViolations.size());
        assertEquals(
                "may not be null",
                constraintViolations.iterator().next().getMessage()
        );
    }

    @Test
    public void createUserWithVeryShortName() {

        User user = new User("a","111", Boolean.TRUE);

        Set<ConstraintViolation<User>> constraintViolations = validator.validate(user);

        assertEquals(1, constraintViolations.size());
        assertEquals(
                "size must be between 2 and 30",
                constraintViolations.iterator().next().getMessage()
        );
    }

    @Test
    public void createUserWithEmptyName() {

        User user = new User("","111", Boolean.TRUE);

        Set<ConstraintViolation<User>> constraintViolations = validator.validate(user);

        assertEquals(1, constraintViolations.size());
        assertEquals(
                "size must be between 2 and 30",
                constraintViolations.iterator().next().getMessage()
        );
    }

    @Test
    public void createUserWithNormalName() {

        User user = new User("bb","111", Boolean.TRUE);

        Set<ConstraintViolation<User>> constraintViolations = validator.validate(user);
        assertEquals(0, constraintViolations.size());
    }
}
