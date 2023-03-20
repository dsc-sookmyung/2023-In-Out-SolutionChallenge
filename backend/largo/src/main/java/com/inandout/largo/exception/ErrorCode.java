package com.inandout.largo.exception;

import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;

@Getter
@RequiredArgsConstructor
public enum ErrorCode {
    RESOURCE_NOT_FOUND(HttpStatus.NOT_FOUND, "해당 리소스가 존재하지 않습니다."),
    FAIL_TO_UPLOAD(HttpStatus.NOT_EXTENDED, "파일 업로드에 실패했습니다");

    private final HttpStatus httpStatus;
    private final String message;
}
