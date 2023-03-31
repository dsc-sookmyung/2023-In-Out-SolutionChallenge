package com.inandout.largo.course.domain;

import com.inandout.largo.user.domain.User;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@Table(name = "user_place")
@Entity
public class UserPlace {
    @Id
    @Column(name = "up_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "user_id", nullable = false)
    private User user;

    @ManyToOne
    @JoinColumn(name = "course_id", referencedColumnName = "course_id", nullable = false)
    private Course course;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String picture;

    @Builder
    public UserPlace(User user, Course course, String picture){
        this.user = user;
        this.course = course;
        this.picture = picture;
    }
}
