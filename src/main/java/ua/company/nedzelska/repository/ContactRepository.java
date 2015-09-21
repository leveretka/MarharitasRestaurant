package ua.company.nedzelska.repository;

import org.springframework.data.repository.Repository;
import ua.company.nedzelska.domain.Contact;

import javax.transaction.Transactional;

/**
 * Created by margarita on 03.09.15.
 */
public interface ContactRepository extends Repository<Contact, Long> {

    @Transactional
    Contact save(Contact contact);

    Contact findByTelAndEmail(String tel, String email);
}
