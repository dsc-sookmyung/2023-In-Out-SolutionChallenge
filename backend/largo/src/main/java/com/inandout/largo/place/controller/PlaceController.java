package com.inandout.largo.place.controller;

import com.inandout.largo.place.dto.*;
import com.inandout.largo.place.service.PlaceService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/places")
public class PlaceController {
    private final PlaceService placeService;

    @GetMapping
    public List<PlaceListResponseDto> getPlacesList(){
        return placeService.findAllPlaces();
    }

    @GetMapping("/{id}")
    public ResponseEntity<PlaceResponseDto> getPlace(@PathVariable Long id){
        return ResponseEntity.ok(placeService.findById(id));
    }

    @PostMapping("/search")
    public ResponseEntity<PlaceSearchResponseDto> findPlaceWithin(@RequestBody PlaceSearchRequestDto requestDto){
        return ResponseEntity.ok(placeService.findPlaceWithin(requestDto));
    }

    @GetMapping("/top")
    public ResponseEntity<PlaceTopListResponseDto> getTopPlaces(@RequestParam Double latitude, @RequestParam Double longitude){
        return ResponseEntity.ok(placeService.findTopPlaces(latitude, longitude));
    }
}
