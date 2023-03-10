package com.inandout.largo.place.controller;

import com.inandout.largo.place.dto.PlaceResponseDto;
import com.inandout.largo.place.service.PlaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/places")
public class PlaceController {
    private final PlaceService placeService;

    @GetMapping
    public List<PlaceResponseDto> getPlacesList(){
        return placeService.findAllPlaces();
    }
}
