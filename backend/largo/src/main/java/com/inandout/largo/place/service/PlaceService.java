package com.inandout.largo.place.service;

import com.inandout.largo.exception.CustomException;
import com.inandout.largo.exception.ErrorCode;
import com.inandout.largo.place.domain.Place;
import com.inandout.largo.place.domain.PlaceRepository;
import com.inandout.largo.place.dto.*;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.List;
import java.util.stream.Collectors;

@RequiredArgsConstructor
@Service
public class PlaceService {
    @Value("${map.api.key}")
    private String apiKey;

    private static final String BASE_URL_STRING = "https://maps.googleapis.com/maps/api/geocode/json";

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

        if(res.isEmpty()) return new PlaceSearchResponseDto();
        res.get(0).updateCount();
        return new PlaceSearchResponseDto(res.get(0));
    }

    @Transactional
    public PlaceTopListResponseDto findTopPlaces(Double latitude, Double longitude) {
        List<PlaceTopResponseDto> total = placeRepository.findTopPlaces();

        String[] address = getAddress(latitude, longitude).split(" ");
        String district = address[address.length-1];
        List<PlaceTopResponseDto> near = placeRepository.findNearByTopPlaces(district);

        if(near.isEmpty()) return new PlaceTopListResponseDto(null, total, null);
        return new PlaceTopListResponseDto(district, total, near);
    }

    private String getAddress(Double latitude, Double longitude){
        // Reverse geocoding request and response
        try {
            URL url = new URL(BASE_URL_STRING+"?latlng="+latitude.toString()+","+longitude.toString()+"&result_type=sublocality_level_1&language=ko&key="+apiKey);
            InputStream inputStream = url.openConnection().getInputStream();

            // read inputStream
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, "UTF-8"));
            StringBuilder response = new StringBuilder();
            String output;
            while((output=reader.readLine()) != null){
                response.append(output);
            }

            // return formatted_address
            JSONParser parser = new JSONParser();
            JSONObject jsonObject = (JSONObject) parser.parse(response.toString());
            JSONArray results = (JSONArray) jsonObject.get("results");

            return ((JSONObject) results.get(0))
                    .get("formatted_address").toString();
        } catch (ParseException | IOException e) {
            throw new RuntimeException(e);
        }
    }
}
