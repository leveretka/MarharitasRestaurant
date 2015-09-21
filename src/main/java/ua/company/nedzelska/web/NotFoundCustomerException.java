package ua.company.nedzelska.web;

/**
 * Created by margarita on 03.09.15.
 */
public class NotFoundCustomerException extends RuntimeException {
    public NotFoundCustomerException(String s) {
        super(s);
    }
}
