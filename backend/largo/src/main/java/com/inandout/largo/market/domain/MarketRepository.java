package com.inandout.largo.market.domain;

import com.inandout.largo.market.dto.MarketResponseDto;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface MarketRepository extends JpaRepository<Market, Long> {
    @Query("select m from Market m order by random() limit 5")
    List<MarketResponseDto> getRand();
}
