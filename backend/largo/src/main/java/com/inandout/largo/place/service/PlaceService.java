package com.inandout.largo.place.service;

import com.inandout.largo.exception.CustomException;
import com.inandout.largo.exception.ErrorCode;
import com.inandout.largo.place.domain.Place;
import com.inandout.largo.place.domain.PlaceRepository;
import com.inandout.largo.place.dto.PlaceResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class PlaceService {
    private final PlaceRepository placeRepository;

    @Transactional
    public List<PlaceResponseDto> findAllPlaces(){
        return placeRepository.findAll().stream()
                .map(PlaceResponseDto::new)
                .collect(Collectors.toList());
    }

    public PlaceResponseDto findById(Long id) {
        Place place = placeRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCode.RESOURCE_NOT_FOUND));
        return new PlaceResponseDto(place);
    }
}
