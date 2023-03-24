package com.inandout.largo.place.dto;

import com.inandout.largo.place.domain.Place;
import lombok.Getter;

import java.util.List;
import java.util.stream.Collectors;

@Getter
public class PlaceResponseDto {
    private Long place_id;
    private String place_name;
    private String address_num;
    private String address_name;
    private Double longitude;
    private Double latitude;
    private String info;
    private String category;
    private String picture;
    private List<String> hashtags;

    public PlaceResponseDto(Place entity){
        this.place_id = entity.getId();
        this.place_name = entity.getName();
        this.address_num = entity.getAddress_num();
        this.address_name = entity.getAddress_name();
        this.longitude = entity.getPt().getX();
        this.latitude = entity.getPt().getY();
        this.info = entity.getInfo();
        this.category = entity.getCategory();
        this.picture = entity.getPicture();
        this.hashtags = entity.getHashtags().stream()
                .map(hashtag -> hashtag.getHashtag().getData())
                .collect(Collectors.toList());
    }
}
