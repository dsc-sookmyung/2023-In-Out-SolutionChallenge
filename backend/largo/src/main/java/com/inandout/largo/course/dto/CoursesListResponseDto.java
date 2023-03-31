package com.inandout.largo.course.dto;

import com.inandout.largo.course.domain.Course;
import lombok.Getter;

@Getter
public class CoursesListResponseDto {
    private Long course_id;
    private String picture;
    private String total_time;
    private Double total_dist;
    private String created_date;

    public CoursesListResponseDto(Course entity){
        this.course_id = entity.getId();
        this.picture = entity.getPicture();
        this.total_time = entity.getTotalTime();
        this.total_dist = entity.getTotalDist();
        this.created_date = entity.getCreatedDate();
    }
}
