package com.inandout.largo.course.dto;

import lombok.Getter;
import lombok.Builder;

@Getter
public class CoordinateDto {
    private Double lat;
    private Double lon;

    @Builder
    public CoordinateDto(Double lat, Double lon){
        this.lat = lat;
        this.lon = lon;
    }
}
