package com.inandout.largo.place.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.locationtech.jts.geom.Point;

import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor
@Entity
public class Place {
    @Id
    @Column(name = "place_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "place_name", unique = true, nullable = false)
    private String name;

    @Column(name = "address_num")
    private String addressNum;

    @Column(name = "address_name")
    private String addressName;

    @Column(columnDefinition = "GEOMETRY(POINT, 4326)", nullable = false)
    private Point pt;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String info;

    @Column(nullable = false)
    private String category;

    @Column(columnDefinition = "TEXT")
    private String picture;

    @Column(name = "search_count", nullable = false)
    private Integer searchCount;

    @Column(nullable = false)
    private String district;

    @OneToMany(mappedBy = "place", targetEntity = PlaceHashtag.class)
    private List<PlaceHashtag> hashtags = new ArrayList<>();

    @Builder
    public Place(String name, String addressNum, String addressName, Point pt, String info, String category, String picture, Integer searchCount, String district){
        this.name = name;
        this.addressNum = addressNum;
        this.addressName = addressName;
        this.pt = pt;
        this.info = info;
        this.category = category;
        this.picture = picture;
        this.searchCount = searchCount;
        this.district = district;
    }

    public void updateCount(){
        this.searchCount+=1;
    }
}
