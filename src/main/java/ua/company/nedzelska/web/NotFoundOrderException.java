package ua.company.nedzelska.web;

/**
 * Created by margarita on 08.09.15.
 */
public class NotFoundOrderException extends RuntimeException {
    public NotFoundOrderException(String s) {
        super(s);
    }
}
