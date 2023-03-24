package com.inandout.largo.course.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserPlaceRepository extends JpaRepository<UserPlace, Long> {
    @Query("select up.picture from UserPlace up where up.user.email=:email order by up.id desc")
    List<String> findAllByUser(@Param("email") String email);
}
