package com.inandout.largo.market.service;

import com.inandout.largo.market.domain.MarketRepository;
import com.inandout.largo.market.dto.MarketResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor
@Service
public class MarketService {
    private final MarketRepository marketRepository;

    @Transactional
    public List<MarketResponseDto> getRandomMarkets(){
        return  marketRepository.getRand();
    }
}
