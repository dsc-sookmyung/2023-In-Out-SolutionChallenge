package com.inandout.largo.course.domain;

import com.inandout.largo.user.domain.User;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Builder;
import org.locationtech.jts.geom.LineString;

@Getter
@NoArgsConstructor
@Entity
public class Course {
    @Id
    @Column(name = "course_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    private User user;

    @Column(columnDefinition = "GEOMETRY(LINESTRING, 4326)", nullable = false)
    private LineString ls;

    @Column(columnDefinition = "TEXT")
    private String picture;

    @Column(name = "total_time", nullable = false)
    private String totalTime;

    @Column(name = "total_dist", nullable = false)
    private Double totalDist;

    @Builder
    public Course(User user, LineString ls, String picture, String totalTime, Double totalDist){
        this.user = user;
        this.ls = ls;
        this.picture = picture;
        this.totalTime = totalTime;
        this.totalDist = totalDist;
    }
}
