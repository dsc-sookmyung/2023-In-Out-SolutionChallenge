package com.inandout.largo.place.dto;

import com.inandout.largo.place.domain.Place;
import lombok.Getter;

@Getter
public class PlaceListResponseDto {
    private Long place_id;
    private Double longitude;
    private Double latitude;

    public PlaceListResponseDto(Place entity){
        this.place_id = entity.getId();
        this.longitude = entity.getPt().getX();
        this.latitude = entity.getPt().getY();
    }
}
