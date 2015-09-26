package ua.company.nedzelska.repository;

import org.springframework.data.repository.Repository;
import ua.company.nedzelska.domain.User;

import javax.transaction.Transactional;

/**
 * Created by margarita on 03.09.15.
 */
public interface UserRepository extends Repository<User, Long> {

    @Transactional
    User save(User user);

    User findUserByName(String name);

    @Transactional
    void delete(User user);
}
