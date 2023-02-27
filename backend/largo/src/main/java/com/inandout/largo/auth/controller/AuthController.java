package com.inandout.largo.auth.controller;

import com.inandout.largo.auth.jwt.JwtResponseDto;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
public class AuthController {
    @GetMapping("/login")
    public ResponseEntity<?> oauthLogin(HttpServletRequest request, HttpServletResponse response, @RequestParam("token") String token){
        JwtResponseDto responseBody = JwtResponseDto.builder()
                .token(token)
                .build();
        return ResponseEntity.ok(responseBody);
    }
}
