package com.inandout.largo.place.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@NoArgsConstructor
public class PlaceSearchRequestDto {
    private Double longitude;
    private Double latitude;
    private List<Long> exclusions;

    @Builder
    public PlaceSearchRequestDto(Double longitude, Double latitude, List<Long> exclusions){
        this.longitude = longitude;
        this.latitude = latitude;
        this.exclusions = exclusions;
    }
}
