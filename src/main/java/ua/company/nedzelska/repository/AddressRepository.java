package ua.company.nedzelska.repository;

import org.springframework.data.repository.Repository;
import ua.company.nedzelska.domain.Address;

import javax.transaction.Transactional;

/**
 * Created by margarita on 03.09.15.
 */
public interface AddressRepository extends Repository<Address, Long> {

    @Transactional
    Address save(Address address);

    Address findByAreaAndDistrictAndCityAndStreetAndBuildingAndApartment(String area, String district, String city, String street, String building, String apartment);
}
