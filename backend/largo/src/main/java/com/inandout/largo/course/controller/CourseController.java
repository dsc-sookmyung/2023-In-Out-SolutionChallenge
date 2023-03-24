package com.inandout.largo.course.controller;

import com.inandout.largo.course.dto.CourseSaveRequestDto;
import com.inandout.largo.course.service.CourseService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/courses")
public class CourseController {
    private final CourseService courseService;

    @PostMapping
    public void saveCourse(@RequestBody CourseSaveRequestDto requestDto){
        courseService.save(requestDto);
    }
}
