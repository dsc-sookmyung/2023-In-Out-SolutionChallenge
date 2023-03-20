package com.inandout.largo.place.service;

import com.inandout.largo.exception.CustomException;
import com.inandout.largo.exception.ErrorCode;
import com.inandout.largo.place.domain.Place;
import com.inandout.largo.place.domain.PlaceRepository;
import com.inandout.largo.place.dto.PlaceSearchRequestDto;
import com.inandout.largo.place.dto.PlaceListResponseDto;
import com.inandout.largo.place.dto.PlaceResponseDto;
import com.inandout.largo.place.dto.PlaceSearchResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class PlaceService {
    private final PlaceRepository placeRepository;

    @Transactional
    public List<PlaceListResponseDto> findAllPlaces(){
        return placeRepository.findAll(Sort.by(Sort.Direction.ASC, "id")).stream()
                .map(PlaceListResponseDto::new)
                .collect(Collectors.toList());
    }

    @Transactional
    public PlaceResponseDto findById(Long id) {
        Place place = placeRepository.findById(id)
                .orElseThrow(() -> new CustomException(ErrorCode.RESOURCE_NOT_FOUND));
        return new PlaceResponseDto(place);
    }

    @Transactional
    public PlaceSearchResponseDto findPlaceWithin(PlaceSearchRequestDto requestDto){
        List<Place> res = requestDto.getExclusions().isEmpty() ? placeRepository.findPlaceWithin(requestDto.getLongitude(), requestDto.getLatitude())
                : placeRepository.findPlaceWithin(requestDto.getLongitude(), requestDto.getLatitude(), requestDto.getExclusions());
        if(res.isEmpty()) throw new CustomException(ErrorCode.RESOURCE_NOT_FOUND);
        return new PlaceSearchResponseDto(res.get(0));
    }
}
