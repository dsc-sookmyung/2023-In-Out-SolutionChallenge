package com.inandout.largo.place.domain;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PlaceRepository extends JpaRepository<Place, Long> {
    @Query(value = "select *, ST_DistanceSphere(p.pt, ST_MakePoint(:longitude, :latitude)) as dist from Place p where p.place_id not in :exclusions and ST_DistanceSphere(p.pt, ST_MakePoint(:longitude, :latitude)) <= 150 order by dist ASC", nativeQuery = true)
    List<Place> findPlaceWithin(@Param("longitude") Double longitude, @Param("latitude") Double latitude, @Param("exclusions") List<Long> exclusions);

    @Query(value = "select *, ST_DistanceSphere(p.pt, ST_MakePoint(:longitude, :latitude)) as dist from Place p where ST_DistanceSphere(p.pt, ST_MakePoint(:longitude, :latitude)) <= 150 order by dist ASC", nativeQuery = true)
    List<Place> findPlaceWithin(@Param("longitude") Double longitude, @Param("latitude") Double latitude);
}
