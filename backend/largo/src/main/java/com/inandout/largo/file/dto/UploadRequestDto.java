package com.inandout.largo.file.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class UploadRequestDto {
    private String path;
    private byte[] file;

    @Builder
    public UploadRequestDto(String path, byte[] file){
        this.path = path;
        this.file = file;
    }
}
