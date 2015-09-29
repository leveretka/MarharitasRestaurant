package ua.company.nedzelska.domain;

import javax.persistence.*;
import javax.validation.constraints.Size;

/**
 * Created by margarita on 01.09.15.
 */
@Entity
@Table(name = "USERS")
public class User {

    @Id
    @GeneratedValue
    @Column(name = "USER_ID")
    private Long id;

    @Size(min=2, max=30, message = "invalid_login")
    @Column(name = "USER_NAME")
    private String name;

    @Size(min=1, max=30, message = "invalid_password")
    @Column(name = "PASSWORD")
    private String pass;

    @Column(name = "ENABLED")
    private Boolean enabled;

    public User(String name, String pass, Boolean enabled) {
        this.name = name;
        this.pass = pass;
        this.enabled = enabled;
    }

    public User() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public Boolean getEnabled() {
        return enabled;
    }

    public void setEnabled(Boolean enabled) {
        this.enabled = enabled;
    }
}
