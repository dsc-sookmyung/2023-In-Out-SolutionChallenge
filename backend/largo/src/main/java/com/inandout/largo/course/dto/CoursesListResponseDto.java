package com.inandout.largo.course.dto;

import com.inandout.largo.course.domain.Course;
import lombok.Getter;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Getter
public class CoursesListResponseDto {
    private Long course_id;
    private List<CoordinateDto> ls;
    private String picture;
    private String total_time;
    private Double total_dist;

    public CoursesListResponseDto(Course entity){
        this.course_id = entity.getId();
        this.ls = Arrays.stream(entity.getLs().getCoordinates())
                .map(coordinate -> CoordinateDto.builder()
                        .lon(coordinate.getX())
                        .lat(coordinate.getY())
                        .build()
                )
                .collect(Collectors.toList());
        this.picture = entity.getPicture();
        this.total_time = entity.getTotalTime();
        this.total_dist = entity.getTotalDist();
    }
}
