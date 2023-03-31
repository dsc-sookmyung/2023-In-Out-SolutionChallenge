package com.inandout.largo.market.dto;

import com.inandout.largo.market.domain.Market;
import lombok.Getter;

@Getter
public class MarketResponseDto {
    private Long market_id;
    private String market_name;
    private String address_name;
    private Double longitude;
    private Double latitude;
    private String picture;

    public MarketResponseDto(Market entity){
        this.market_id = entity.getId();
        this.market_name = entity.getName();
        this.address_name = entity.getAddressName();
        this.longitude = entity.getPt().getX();
        this.latitude = entity.getPt().getY();
        this.picture = entity.getPicture();
    }
}
