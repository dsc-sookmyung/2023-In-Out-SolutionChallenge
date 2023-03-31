package com.inandout.largo.market.controller;

import com.inandout.largo.market.dto.MarketResponseDto;
import com.inandout.largo.market.service.MarketService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/markets")
public class MarketController {
    private final MarketService marketService;

    @GetMapping
    public List<MarketResponseDto> getMarketsList(){
        return marketService.getRandomMarkets();
    }
}
