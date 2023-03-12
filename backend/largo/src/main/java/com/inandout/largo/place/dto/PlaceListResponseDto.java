package com.inandout.largo.place.dto;

import com.inandout.largo.place.domain.Place;
import lombok.Getter;

@Getter
public class PlaceListResponseDto {
    private Long id;
    private Double lon;
    private Double lat;

    public PlaceListResponseDto(Place entity){
        this.id = entity.getId();
        this.lon = entity.getPt().getX();
        this.lat = entity.getPt().getY();
    }
}
