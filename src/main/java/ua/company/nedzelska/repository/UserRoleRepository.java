package ua.company.nedzelska.repository;

import org.springframework.data.repository.Repository;
import ua.company.nedzelska.domain.UserRole;

import javax.transaction.Transactional;
import java.util.List;

/**
 * Created by margarita on 9/25/15.
 */
public interface UserRoleRepository extends Repository<UserRole, Long> {

    @Transactional
    UserRole save(UserRole userRole);

    List<UserRole> findUserRolesByUserId(Long userId);

    @Transactional
    void delete(UserRole userRole);
}
