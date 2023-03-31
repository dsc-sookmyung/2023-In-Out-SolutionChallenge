package com.inandout.largo.course.service;

import com.inandout.largo.course.domain.Course;
import com.inandout.largo.course.domain.CourseRepository;
import com.inandout.largo.course.dto.CourseSaveRequestDto;
import com.inandout.largo.course.dto.CoordinateDto;
import com.inandout.largo.course.dto.CoursesListResponseDto;
import com.inandout.largo.exception.CustomException;
import com.inandout.largo.exception.ErrorCode;
import com.inandout.largo.course.domain.UserPlaceRepository;
import com.inandout.largo.user.domain.User;
import com.inandout.largo.user.domain.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.locationtech.jts.geom.Coordinate;
import org.locationtech.jts.geom.GeometryFactory;
import org.locationtech.jts.geom.LineString;
import org.locationtech.jts.geom.PrecisionModel;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@Service
public class CourseService {
    private final CourseRepository courseRepository;
    private final UserRepository userRepository;
    private final UserPlaceRepository userPlaceRepository;

    @Transactional
    public void save(CourseSaveRequestDto requestDto, String email){
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));
        LineString ls = getLineString(requestDto.getLs());

        Course course = courseRepository.save(requestDto.toCourseEntity(user, ls));
        for(int i=0;i<requestDto.getUser_picture().size();i++){
            userPlaceRepository.save(requestDto.toUPEntity(user, course, requestDto.getUser_picture().get(i)));
        }

        user.addReward();
        log.info("save course {}", course.getId());
    }

    public LineString getLineString(List<CoordinateDto> coordinateDtos){
        GeometryFactory geometryFactory = new GeometryFactory(new PrecisionModel(), 4326);
        Coordinate[] coordinates = new Coordinate[coordinateDtos.size()];
        for (int i=0;i<coordinateDtos.size();i++){
            coordinates[i] = new Coordinate(coordinateDtos.get(i).getLon(), coordinateDtos.get(i).getLat());
        }
        LineString lineString = geometryFactory.createLineString(coordinates);
        log.info(lineString.toString());

        return lineString;
    }

    @Transactional
    public List<CoursesListResponseDto> findAllCourses(String email){
        return courseRepository.findAllByUser(email).stream()
                .map(CoursesListResponseDto::new)
                .toList();
    }

    @Transactional
    public List<String> findAllPictures(String email){
        return userPlaceRepository.findAllByUser(email);
    }
}
