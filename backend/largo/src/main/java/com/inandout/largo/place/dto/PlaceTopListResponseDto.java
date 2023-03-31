package com.inandout.largo.place.dto;

import lombok.Getter;

import java.util.List;

@Getter
public class PlaceTopListResponseDto {
    private String district;
    private List<PlaceTopResponseDto> total;
    private List<PlaceTopResponseDto> near;

    public PlaceTopListResponseDto(String district, List<PlaceTopResponseDto> total, List<PlaceTopResponseDto> near){
        this.district = district;
        this.total = total;
        this.near = near;
    }
}
