package com.inandout.largo.course.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CourseRepository extends JpaRepository<Course, Long> {
    @Query("select c from Course c where c.user.email=:email order by c.id desc")
    List<Course> findAllByUser(@Param("email") String email);
}
