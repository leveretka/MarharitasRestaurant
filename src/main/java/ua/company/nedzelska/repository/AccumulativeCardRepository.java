package ua.company.nedzelska.repository;

import org.springframework.data.repository.Repository;
import ua.company.nedzelska.domain.AccumulativeCard;

import javax.transaction.Transactional;

/**
 * Created by margarita on 03.09.15.
 */
public interface AccumulativeCardRepository extends Repository<AccumulativeCard, Long> {

    @Transactional
    AccumulativeCard save(AccumulativeCard accumulativeCard);

    AccumulativeCard findAccumulativeCardById(Long id);
}
