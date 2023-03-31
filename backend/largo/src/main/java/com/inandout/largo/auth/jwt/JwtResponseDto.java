package com.inandout.largo.auth.jwt;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class JwtResponseDto {
    private String token;

    @Builder
    public JwtResponseDto(String token){
        this.token = token;
    }
}
