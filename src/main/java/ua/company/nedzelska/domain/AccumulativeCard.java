package ua.company.nedzelska.domain;

import javax.persistence.*;

/**
 * Created by margarita on 01.09.15.
 */
@Entity
@Table(name = "ACCUMULATIVE_CARDS")
public class AccumulativeCard {

    @Id
    @GeneratedValue
    @Column(name = "ACCUMULATIVE_CARD_ID")
    private Long id;

    @Column(name = "ACCUMULATED_SUM")
    private Double sum;

    public AccumulativeCard(Double sum) {
        this.sum = sum;
    }

    public AccumulativeCard() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Double getSum() {
        return sum;
    }

    public void setSum(Double sum) {
        this.sum = sum;
    }

    public void add(double sum) {
        this.sum += sum;
    }
}
