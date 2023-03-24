package com.inandout.largo.course.controller;

import com.inandout.largo.course.dto.CourseSaveRequestDto;
import com.inandout.largo.course.dto.CoursesListResponseDto;
import com.inandout.largo.course.service.CourseService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/courses")
public class CourseController {
    private final CourseService courseService;

    @PostMapping
    public void saveCourse(@RequestBody CourseSaveRequestDto requestDto){
        courseService.save(requestDto);
    }

    @GetMapping
    public List<CoursesListResponseDto> getCoursesList(Principal principal){
        return courseService.findAllCourses(principal.getName());
    }

    @GetMapping("/pictures")
    public List<String> getPicturesList(Principal principal){
        return courseService.findAllPictures(principal.getName());
    }
}
