package ua.company.nedzelska.domain;

import javax.persistence.*;

/**
 * Created by margarita on 01.09.15.
 */
@Entity
@Table(name = "ADDRESSES")
public class Address {

    @Id
    @GeneratedValue
    @Column(name = "ADDRESS_ID")
    private Long id;

    @Column(name = "AREA")
    private String area;

    @Column(name = "DISTRICT")
    private String district;

    @Column(name = "CITY")
    private String city;

    @Column(name = "STREET")
    private String street;

    @Column(name = "BUILDING")
    private String building;

    @Column(name = "APARTMENT")
    private String apartment;

    public Address(String area, String district, String city, String street, String building, String apartment) {
        this.area = area;
        this.district = district;
        this.city = city;
        this.street = street;
        this.building = building;
        this.apartment = apartment;
    }

    public Address() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }

    public String getApartment() {
        return apartment;
    }

    public void setApartment(String apartment) {
        this.apartment = apartment;
    }

    @Override
    public String toString() {
        return "Address{" +
                " area='" + area + '\'' +
                ", district='" + district + '\'' +
                ", city='" + city + '\'' +
                ", street='" + street + '\'' +
                ", building='" + building + '\'' +
                ", apartment='" + apartment + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Address)) return false;

        Address address = (Address) o;

        if (id.equals(address.id)) return true;
        if(address.id == null) {

            if (!apartment.equals(address.apartment)) return false;
            if (area != null ? !area.equals(address.area) : address.area != null) return false;
            if (!building.equals(address.building)) return false;
            if (!city.equals(address.city)) return false;
            if (district != null ? !district.equals(address.district) : address.district != null) return false;
            if (!street.equals(address.street)) return false;

            return true;
        }
        return false;
    }

    @Override
    public int hashCode() {
        int result = apartment.hashCode();
        result = 31 * result + (area != null ? area.hashCode() : 0);
        result = 31 * result + (district != null ? district.hashCode() : 0);
        result = 31 * result + city.hashCode();
        result = 31 * result + street.hashCode();
        result = 31 * result + building.hashCode();
        return result;
    }
}
