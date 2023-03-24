package com.inandout.largo.course.dto;

import com.inandout.largo.course.domain.Course;
import com.inandout.largo.course.domain.UserPlace;
import com.inandout.largo.user.domain.User;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Builder;
import org.locationtech.jts.geom.LineString;

import java.util.List;

@Getter
@NoArgsConstructor
public class CourseSaveRequestDto {
    private String email;
    private List<CoordinateDto> ls;
    private String total_time;
    private Double total_dist;
    private String map_picture;
    private List<String> user_picture;

    @Builder
    public CourseSaveRequestDto(String email, List<CoordinateDto> ls, String total_time, Double total_dist, String map_picture, List<String> user_picture){
        this.email = email;
        this.ls = ls;
        this.total_time = total_time;
        this.total_dist = total_dist;
        this.map_picture = map_picture;
        this.user_picture = user_picture;
    }

    public Course toCourseEntity(User user, LineString ls){
        return Course.builder()
                .user(user)
                .ls(ls)
                .picture(map_picture)
                .totalTime(total_time)
                .totalDist(total_dist)
                .build();
    }

    public UserPlace toUPEntity(User user, Course course, String picture){
        return UserPlace.builder()
                .user(user)
                .course(course)
                .picture(picture)
                .build();
    }
}
