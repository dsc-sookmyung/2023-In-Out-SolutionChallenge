package com.inandout.largo.place.dto;

import com.inandout.largo.place.domain.Place;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
public class PlaceTopResponseDto {
    private Long place_id;
    private String place_name;
    private String address;
    private String picture;
    private List<String> hashtags;

    public PlaceTopResponseDto(Place entity){
        this.place_id = entity.getId();
        this.place_name = entity.getName();
        this.address = entity.getAddressNum();
        if(this.address == null || this.address.equals("")) this.address = entity.getAddressName();
        this.picture = entity.getPicture();
        this.hashtags = entity.getHashtags().stream()
                .map(mapper -> mapper.getHashtag().getData())
                .collect(Collectors.toList());
    }
}
