package com.inandout.largo.place.controller;

import com.inandout.largo.place.dto.PlaceResponseDto;
import com.inandout.largo.place.service.PlaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/places")
public class PlaceController {
    private final PlaceService placeService;

    @GetMapping
    public List<PlaceResponseDto> getPlaceList(){
        return placeService.findAllPlaces();
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getPlace(@PathVariable Long id){
        return ResponseEntity.ok(placeService.findById(id));
    }
}
