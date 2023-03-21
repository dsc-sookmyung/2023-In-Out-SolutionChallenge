package com.inandout.largo.place.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@NoArgsConstructor
@Table(name = "place_hashtag")
@Entity
public class PlaceHashtag {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "place_id", referencedColumnName = "place_id", nullable = false)
    private Place place;

    @ManyToOne
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "tag_id", referencedColumnName = "tag_id", nullable = false)
    private Hashtag hashtag;

    @Builder
    public PlaceHashtag(Place place, Hashtag hashtag){
        this.place = place;
        this.hashtag = hashtag;
    }
}
