package com.inandout.largo.user.dto;

import com.inandout.largo.user.domain.User;
import lombok.Getter;

@Getter
public class UserResponseDto {
    private String user_name;
    private String picture;
    private int reward;
    private boolean agreement;

    public UserResponseDto(User entity){
        this.user_name = entity.getName();
        this.picture = entity.getPicture();
        this.reward = entity.getReward();
        this.agreement = entity.isAgreement();
    }
}
