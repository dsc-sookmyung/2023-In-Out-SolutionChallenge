package com.inandout.largo.place.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Getter
@NoArgsConstructor
@Entity
public class Hashtag {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long tag_id;

    @Column(nullable = false)
    private String data;

    @OneToMany(mappedBy = "hashtag", targetEntity = PlaceHashtag.class)
    private List<Place> places = new ArrayList<>();

    @Builder
    public Hashtag(String data){
        this.data = data;
    }
}
