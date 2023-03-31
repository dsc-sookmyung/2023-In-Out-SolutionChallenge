package com.inandout.largo.place.dto;

import com.inandout.largo.place.domain.Place;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class PlaceSearchResponseDto {
    private Long place_id;
    private String place_name;
    private String info;

    public PlaceSearchResponseDto(Place entity){
        this.place_id = entity.getId();
        this.place_name = entity.getName();
        this.info = entity.getInfo();
    }
}
