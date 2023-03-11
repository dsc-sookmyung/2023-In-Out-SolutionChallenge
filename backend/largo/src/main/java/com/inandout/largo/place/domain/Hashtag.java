package com.inandout.largo.place.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

@Getter
@NoArgsConstructor
@Entity
public class Hashtag {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long tag_id;

    @ManyToOne
    @OnDelete(action = OnDeleteAction.CASCADE)
    @JoinColumn(name = "place_id", referencedColumnName = "place_id", nullable = false)
    private Place place;

    @Column(nullable = false)
    private String data;

    @Builder
    public Hashtag(Place place, String data){
        this.place = place;
        this.data = data;
    }
}
