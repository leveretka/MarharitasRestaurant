package ua.company.nedzelska.domain;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import javax.persistence.*;
import javax.validation.constraints.Pattern;

/**
 * Created by margarita on 01.09.15.
 */

@Entity
@Table(name = "CONTACTS")
public class Contact {

    @Id
    @GeneratedValue
    @Column(name = "CONTACT_ID")
    private Long id;

    @Pattern(regexp = "^[0-9+\\-\\s]+$", message = "Wrong telephone number")
    @Column(name = "TELEPHONE")
    private String tel;

    @NotEmpty(message = "Email required")
    @Email(message = "Wrong E-mail")
    @Column(name = "E_MAIL")
    private String email;

    public Contact() {
    }

    public Contact(String tel, String email) {
        this.tel = tel;
        this.email = email;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Contact)) return false;

        Contact contact = (Contact) o;

        if (!email.equals(contact.email)) return false;
        if (!tel.equals(contact.tel)) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = tel.hashCode();
        result = 31 * result + email.hashCode();
        return result;
    }
}
