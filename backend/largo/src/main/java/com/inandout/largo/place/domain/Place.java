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

    @Column
    private String address_num;

    @Column
    private String address_name;

    @Column(columnDefinition = "GEOMETRY(POINT, 4326)", nullable = false)
    private Point pt;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String info;

    @Column(nullable = false)
    private String category;

    @Column(columnDefinition = "TEXT")
    private String picture;

    @OneToMany(mappedBy = "place", targetEntity = Place_Hashtag.class)
    private List<Hashtag> hashtags = new ArrayList<>();

    @Builder
    public Place(String name, String address_num, String address_name, Point pt, String info, String category, String picture){
        this.name = name;
        this.address_num = address_num;
        this.address_name = address_name;
        this.pt = pt;
        this.info = info;
        this.category = category;
        this.picture = picture;
    }
}
