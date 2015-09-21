package ua.company.nedzelska.domain;

import javax.persistence.*;

/**
 * Created by margarita on 01.09.15.
 */

@Entity
@Table(name = "USER_ROLES")
public class UserRole {

    @Id
    @GeneratedValue
    @Column(name = "USER_ROLE_ID")
    private Long id;

    @OneToOne
    @JoinColumn(name = "USER_ID")
    private  User user;

    @Enumerated(value = EnumType.STRING)
    @Column(name = "AUTHORITY")
    private Authority authority;

    public UserRole(User user, Authority authority) {
        this.user = user;
        this.authority = authority;
    }

    public UserRole() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Authority getAuthority() {
        return authority;
    }

    public void setAuthority(Authority authority) {
        this.authority = authority;
    }
}
