package com.inandout.largo.user.service;

import com.inandout.largo.exception.CustomException;
import com.inandout.largo.exception.ErrorCode;
import com.inandout.largo.user.domain.User;
import com.inandout.largo.user.domain.UserRepository;
import com.inandout.largo.user.dto.UserResponseDto;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
public class UserService {
    private final UserRepository userRepository;

    @Transactional
    public UserResponseDto findByEmail(String email) {
        User user = userRepository.findByEmail(email)
                .orElseThrow(() -> new CustomException(ErrorCode.USER_NOT_FOUND));
        return new UserResponseDto(user);
    }
}
