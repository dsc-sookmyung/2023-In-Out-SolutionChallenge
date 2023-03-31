package com.inandout.largo.market.domain;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.locationtech.jts.geom.Point;

@Getter
@NoArgsConstructor
@Entity
public class Market {
    @Id
    @Column(name = "market_id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "market_name", nullable = false)
    private String name;

    @Column(name = "address_num")
    private String addressNum;

    @Column(name = "address_name")
    private String addressName;

    @Column(columnDefinition = "GEOMETRY(POINT, 4326)", nullable = false)
    private Point pt;

    @Column(columnDefinition = "TEXT")
    private String picture;

    @Builder
    public Market(String name, String addressNum, String addressName, Point pt, String picture){
        this.name = name;
        this.addressNum = addressNum;
        this.addressName = addressName;
        this.pt = pt;
        this.picture = picture;
    }
}
